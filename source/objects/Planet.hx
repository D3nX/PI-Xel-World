package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Planet extends FlxSprite {

    public var initialPosition : FlxPoint;

    public function new() {
        super(0, FlxG.height / 2);

        loadGraphic(AssetPaths.planet__png);

        x = (FlxG.width - this.width) / 2;

        initialPosition = new FlxPoint((FlxG.width - this.width) / 2, FlxG.height / 2);
    }

    override public function update(elapsed : Float) : Void {
        super.update(elapsed);

        angle -= 0.8;

        this.velocity.x = 0;
        this.velocity.y = 0;
                    
        if (this.x != initialPosition.x) this.x = initialPosition.x;
        if (this.y != initialPosition.y) this.y = initialPosition.y;
    }

}
