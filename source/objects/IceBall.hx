package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class IceBall extends FlxSprite {

    public var rotateTime : Float;
    public var speed : Float;

    public function new() {
        super();

        loadGraphic(AssetPaths.snowball__png);

        rotateTime = 0;
        speed = 1.0;
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        rotateTime -= (Main.SPEED / 1000.0) * speed;

        x = (FlxG.width / 2 + Math.cos(rotateTime) * (400 + width/2)) - width/2;
	    y = (Main.PLANET_Y + 400 + Math.sin(rotateTime) * (400 + height/2)) - height/2;
		angle = 180 / Math.PI * Math.atan2((Main.PLANET_Y + 400) - y, (FlxG.width / 2) - x) + 90*3;
    }

}