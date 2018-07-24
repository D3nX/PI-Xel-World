package objects;

import flixel.*;
import flixel.math.FlxRandom;

class Cloud extends FlxSprite {

    public var rotateTime : Float;
    private var rotateSpeed : Float;

    public function new() {
        super(0, 0);

        loadGraphic(AssetPaths.cloud__png);

        rotateTime = 0.0;
        rotateSpeed = 1800.0 + new FlxRandom().int(-200, 200);
    }

    override public function update(elapsed : Float) {

        rotateTime -= Main.SPEED / rotateSpeed;

        x = (FlxG.width / 2 + Math.cos(rotateTime) * 600) - width/2;
	    y = (Main.PLANET_Y + 400 + Math.sin(rotateTime) * 600) - height/2;
		angle = 180 / Math.PI * Math.atan2((Main.PLANET_Y + 400) - y, (FlxG.width / 2) - x) + 90*3+10;
    }

}