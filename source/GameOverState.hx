package;

import flixel.*;
import flixel.util.*;
import flixel.text.*;
import flixel.math.*;

class GameOverState extends FlxState {

    var gameOverText : FlxText;
    var text : FlxText;
    var rectangle : FlxSprite;

    override public function create() : Void {

        // Add the game over screen text
        gameOverText = new FlxText();
        gameOverText.size = 45;
        gameOverText.text = "Game Over !\nScore : " + Main.SCORE + "\nIce Balls : " + Main.ICE_BALLS;
        gameOverText.screenCenter(FlxAxes.XY);
        gameOverText.y -= 25;
        gameOverText.color = FlxColor.RED;

        add(gameOverText);

        // Add the selector
        rectangle = new FlxSprite();
        rectangle.makeGraphic(200, 60, FlxColor.RED);
        rectangle.x = 20;
        rectangle.y = FlxG.height-rectangle.height - 20;

        add(rectangle);

        // Add "button" text
        text = new FlxText();
        text.size = 23;
        text.text = "Back menu\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tExit";
        text.x = 20;
        text.y = FlxG.height - text.getHitbox().height - 25;

        add(text);

        // In case the sound don't stopped itself
        if (FlxG.sound.music != null)
            if (FlxG.sound.music.playing)
                FlxG.sound.music.stop();

        super.create();
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        if (FlxG.keys.pressed.RIGHT)
            rectangle.x = FlxG.width - rectangle.width - 20;

        if (FlxG.keys.pressed.LEFT)
            rectangle.x = 20;

        if (FlxG.keys.pressed.ENTER) {
            if (rectangle.x == FlxG.width - rectangle.width - 20) {
                // Sys.exit(0);
            } else if (rectangle.x == 20) {
                // Should be menu, but go to PlayState for the moment...
                Main.SPEED = 8.0;
                Main.ICE_BALLS = 0;
                Main.SCORE = 0;
                FlxG.camera.fade(FlxColor.BLACK, 0.40, false, function() {
                    FlxG.switchState(new MenuState());
                });
            }
        }

    }

}