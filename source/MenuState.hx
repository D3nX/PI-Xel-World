package;

import flixel.*;
import flixel.util.*;
import flixel.text.*;

class MenuState extends FlxState {

    var backgroundImg : FlxSprite;

    var titleText : FlxText;
    var choicesText : FlxText;

    var rectangle : FlxSprite;

    override public function create() : Void {

        // Loading the background
        backgroundImg = new FlxSprite();
        backgroundImg.loadGraphic(AssetPaths.background__png);
        backgroundImg.x = (FlxG.width - backgroundImg.width) / 2;
		backgroundImg.y = -120;
        add(backgroundImg);

        // Initialize the rectangle selector
        rectangle = new FlxSprite();
        rectangle.makeGraphic(200, 60, FlxColor.RED);
        rectangle.x = 20;
        rectangle.y = FlxG.height-rectangle.height - 20;

        add(rectangle);

        // The title text
        titleText = new FlxText();
        titleText.text = "PI-Xel World";
        titleText.size = 45;
        titleText.screenCenter(FlxAxes.X);
        titleText.y = 50;
        titleText.color = FlxColor.CYAN;

        add(titleText);
        
        // The choices text
        choicesText = new FlxText();
        choicesText.text = "Start\n\nExit";
        choicesText.size = 35;
        choicesText.screenCenter(FlxAxes.Y);
        choicesText.x = 25;
        choicesText.color = FlxColor.WHITE;

        add(choicesText);

        // Set the rectangle initial size
        rectangle.y = choicesText.y;

        // In case the sound don't stopped itself
        if (FlxG.sound.music != null)
            if (FlxG.sound.music.playing)
                FlxG.sound.music.stop();

        // Call the super creators
        super.create();
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        backgroundImg.angle -= 0.2;

        if (FlxG.keys.justPressed.UP)
            rectangle.y = choicesText.y;

        if (FlxG.keys.justPressed.DOWN)
            rectangle.y = choicesText.y + choicesText.height/2;

        if (FlxG.keys.justPressed.ENTER) {
            if (rectangle.y == choicesText.y) {
                FlxG.camera.fade(FlxColor.BLACK, 0.40, false, function() {
                    FlxG.switchState(new PlayState());
                });
            } else if (rectangle.y == choicesText.y+choicesText.height/2) {
                // Sys.exit(0);
            }
        }
    }

}