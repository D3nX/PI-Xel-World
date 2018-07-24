package objects;

import flixel.*;
import flixel.math.FlxPoint;

class Player extends FlxSprite {

    public var onGround : Bool;
    public var canJump : Bool;
    public var speed : Float;
    public var eating : Int;
    public var die : Bool;

    public function new() {
        super(0, 0);
        
        loadGraphic(AssetPaths.cube_anim__png, true, 64, 64);

        animation.add("normal", [0], 0);
        animation.add("die", [1], 0);
        animation.add("eat", [2], 0);

        animation.play("normal");

        x = (FlxG.width - this.width) / 2;
        speed = 0.0;
        velocity.y = 1100;
        onGround = false;
        canJump = false;
        die = false;
        eating = -1;
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        // Jumping stuff
        var keysPressed : Bool = (FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP);

        if (keysPressed && velocity.y > -290 && canJump) {
            velocity.y -= 30 - Math.abs(velocity.y) / 10.0;

            if (velocity.y <= -290) canJump = false;
        }

        if (!canJump && velocity.y < 1100 || (!onGround && velocity.y < 1100 && !keysPressed)) {
            velocity.y += 10;
            if (FlxG.keys.pressed.DOWN)
                velocity.y += 15;
            canJump = false;
        }

        if (onGround) {
            speed = 0;
        } else {
            if (Std.int(speed) > 0)
                speed -= 0.1;
            else if (Std.int(speed) < 0)
                speed += 0.1;
        }

        if (onGround) {
            canJump = true;
            if (!keysPressed) velocity.y = 0;

            // Speed stuff
            if (FlxG.keys.pressed.RIGHT)
                speed = 4
            else if (FlxG.keys.pressed.LEFT)
                speed = -4;
        }

        if (eating >= 0) {
            eating++;

            if (eating >= 10) {
                eating = -1;
                animation.play("normal");
            }
        }
    }

    public function eat() : Void {
        animation.play("eat");
        eating = 0;
    }

    public function frozeAndDie() : Void {
        animation.play("die");
        die = true;
    }

}