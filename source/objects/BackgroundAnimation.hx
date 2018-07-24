package objects;

import flixel.*;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;

class BackgroundAnimation extends FlxTypedGroup<FlxSprite> {

    var backgroundImg : FlxSprite;
    var sprites : Array<FlxSprite>;

    var clouds : Array<Cloud>;

    var rotateTime : Float;

    public function new() {
        super();

        // Loading the background
        backgroundImg = new FlxSprite();
        backgroundImg.loadGraphic(AssetPaths.background__png);
        backgroundImg.x = (FlxG.width - backgroundImg.width) / 2;
		backgroundImg.y = -120;
        add(backgroundImg);

        // Add the clouds
		clouds = new Array<Cloud>();
		for (i in 0...4) {
			clouds.push(new Cloud());
			clouds[i].rotateTime = new FlxRandom().int(0, 360);
			add(clouds[i]);
		}

        // Creating the sprite array
        sprites = new Array<FlxSprite>();

        // Tree
        for (i in 0...8) {
            sprites.push(new FlxSprite());
            sprites[i].loadGraphic(AssetPaths.tree__png);
            sprites[i].scale.x = new FlxRandom().int(4, 6) / 10.0;
            sprites[i].scale.y = sprites[i].scale.x;
        }

        // Adding tree to the render
        for (s in sprites)
            add(s);

        rotateTime = 0;
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        var i : Int = 0;
        for (s in sprites) {
            s.x = (FlxG.width / 2 + Math.cos(rotateTime+i) * (400 + s.height*(s.scale.y - 0.05)/2)) - s.width/2;
	        s.y = (Main.PLANET_Y + 400 + Math.sin(rotateTime+i) * (400 + s.height*(s.scale.y - 0.05)/2)) - s.height/2;
		    s.angle = 180 / Math.PI * Math.atan2((Main.PLANET_Y + 400) - s.y, (FlxG.width / 2) - s.x) + 90*3+10;

            i++;
        }

        rotateTime -= Main.SPEED * 0.001;

        backgroundImg.angle -= 0.2;
    }

}