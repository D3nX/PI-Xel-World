package objects;

import flixel.*;

class Tile extends FlxSprite {

    public var rotateTime : Float;
    public var tx : Float;
    public var ty : Float;

    public function new() {
        super(0, 0);

        this.loadGraphic(AssetPaths.tile__png);

        rotateTime = 0.0;
        tx = 0.0;
        ty = 0.0;
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        rotateTime -= Main.SPEED / 1000.0;

        x = (FlxG.width / 2 + Math.cos(rotateTime+(6.25/width)*(tx / width)) * (400 + ty)) - width/2;
	    y = (Main.PLANET_Y + 400 + Math.sin(rotateTime+(6.25/width)*(tx / width)) * (400 + ty)) - height/2;
		angle = 180 / Math.PI * Math.atan2((Main.PLANET_Y + 400) - y, (FlxG.width / 2) - x) + 90*3+3;
    }

}