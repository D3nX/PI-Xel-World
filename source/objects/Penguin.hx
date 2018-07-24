package objects;

import flixel.*;

class Penguin extends FlxSprite {

    public var rotateTime : Float;
    private var selfRotateTime : Float;

    public var speed : Float;
    public var dying : Bool;

    public var globalSpeed : Float;

    public function new() {
        super();

        loadGraphic(AssetPaths.penguin__png);

        globalSpeed = Main.SPEED;

        rotateTime = 0.0;
        selfRotateTime = 0.0;

        speed = 1.0;
        dying = false;
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);
        
        if (!dying) {
            rotateTime += (globalSpeed / 2000.0) * speed;
            selfRotateTime -= 0.2;

            x = (FlxG.width / 2 + Math.cos(rotateTime) * (400 + width/2)) - width/2;
            y = (Main.PLANET_Y + 400 + Math.sin(rotateTime) * (400 + height/2)) - height/2;
            angle = 180 / Math.PI * Math.atan2((Main.PLANET_Y + 400) - y, (FlxG.width / 2) - x) + 90*3;
            angle += -8 + Math.cos(selfRotateTime) * 24;
        } else {
            if (angle%360 < 180) angle += 2.0;
            if (angle%360 > 180) angle -= 2.0;

            if (velocity.y < 1000) {
                velocity.y += 15;
            }

            if (y > FlxG.height) {
                rotateTime = 0.0;
                selfRotateTime = 0.0;

                speed = 1.0;
                dying = false;
            }
        }
    }

    public function die() : Void {
        dying = true;
        velocity.y = -400;
    }

}