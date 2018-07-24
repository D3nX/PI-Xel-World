package objects;

import flixel.*;
import flixel.math.*;
import flixel.group.FlxGroup.FlxTypedGroup;

class TileChain extends FlxTypedGroup<FlxSprite> {

    public var curFormation : Int;

    public var tiles : Array<Tile>;
    private var formations : Array<String>;
    private var formationReset : Bool;

    public function new() {
        super();

        curFormation = 0;

        tiles = new Array<Tile>();

        formations = new Array<String>();
        formations.push("1,1,1,-1,0,0,0,-1,0,0,0,-1,0,0,0,-1,1,0,0");
        formations.push("0,0,0,-1,0,0,1,-1,0,1,1,-1,1,1,1");
        formations.push("1,1,1,0,-1,0,0,0,0,-1,0,0,0,0,-1,0,0,0,0,-1,0,0,1,1");
        formations.push("0,0,1,0,-1,0,1,1,0,-1,1,1,1,1");
        formations.push("0,0,1,-1,0,1,0,-1,1,0,0,0,0,1,-1,0,0,0,0,1,-1,0,0,0,1");
        formations.push("1,1,1,1,1,-1,1,1,1,1,1,-1,1,1,1,1,1,-1,1,1,1,1,1,-1,-1");
        formations.push("1,0,0,-1,0,0,0,-1,0,0,0,-1,0,0,0,-1,1,0,0,-1,1,1,0");


        formationReset = false;

        setFormation(curFormation);
    }

    override public function update(elapsed : Float) {
        super.update(elapsed);

        var outScreen : Int = 0;
        for (t in tiles)
            if (!t.isOnScreen(null) || !t.active || !t.visible)
                outScreen++;

        /*trace("Out of screen : " + outScreen);
        trace("Array length : " + tiles.length);
        trace("Formation reset : " + formationReset);
        trace("\n");*/

        if (outScreen == tiles.length) {
            if (!formationReset) {
                var lastFormation = curFormation;

                while (lastFormation == curFormation)
                    curFormation = new FlxRandom().int(0, formations.length-1);

                setFormation(curFormation);

                formationReset = true;
            }
        } else {
            formationReset = false;
        }
    }

    public function setFormation(curFormation : Int) : Void {

        var x : Float = 0;
        var y : Float = 48*(formations[curFormation].split("-1").length-1);
        var i : Int = 0;

        for (t in tiles) {
            t.visible = false;
            t.active = false;
        }

        for (nmb in formations[curFormation].split(",")) {

            if (nmb != "-1") {
                if (tiles.length < i+1) {
                    tiles.push(new Tile());
                    add(tiles[i]);
                }

                if (nmb == "0") {
                    tiles[i].visible = false;
                    tiles[i].active = false;
                } else if (nmb == "1") {
                    tiles[i].visible = true;
                    tiles[i].active = true;
                }
                tiles[i].rotateTime = 0.0;
                tiles[i].tx = tiles[i].width/2 + x;
                tiles[i].ty = tiles[i].height/2 + y;
                tiles[i].update(0.0);

                x += tiles[i].width;
                i++;
            } else {
                x = 0;
                y -= tiles[i-1].height;
            }
        }
    }

    public function playerCollides(player : Player) : Bool {
        for (t in tiles)
            if (FlxG.pixelPerfectOverlap(t, player))
                return true;

        return false;
    }

}