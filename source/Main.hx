package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {

	public static var SCORE : Int = 0;
	public static var ICE_BALLS : Int = 0;
	public static var SPEED : Float = 8.0;
	public static var PLANET_Y : Float = 0.0;

	public function new() {
		super();
		addChild(new FlxGame(0, 0, MenuState));
	}
}
