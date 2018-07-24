package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/images/background.png", "assets/images/background.png");
			type.set ("assets/images/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/cloud.png", "assets/images/cloud.png");
			type.set ("assets/images/cloud.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/cube_anim.png", "assets/images/cube_anim.png");
			type.set ("assets/images/cube_anim.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/penguin.png", "assets/images/penguin.png");
			type.set ("assets/images/penguin.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/planet.png", "assets/images/planet.png");
			type.set ("assets/images/planet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/snowball.png", "assets/images/snowball.png");
			type.set ("assets/images/snowball.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tile.png", "assets/images/tile.png");
			type.set ("assets/images/tile.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tmp/add_star.rb", "assets/images/tmp/add_star.rb");
			type.set ("assets/images/tmp/add_star.rb", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/tmp/background_old.png", "assets/images/tmp/background_old.png");
			type.set ("assets/images/tmp/background_old.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tmp/cube.png", "assets/images/tmp/cube.png");
			type.set ("assets/images/tmp/cube.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tmp/cube_destroyed.png", "assets/images/tmp/cube_destroyed.png");
			type.set ("assets/images/tmp/cube_destroyed.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tmp/cube_eat.png", "assets/images/tmp/cube_eat.png");
			type.set ("assets/images/tmp/cube_eat.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tmp/star.png", "assets/images/tmp/star.png");
			type.set ("assets/images/tmp/star.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tree.png", "assets/images/tree.png");
			type.set ("assets/images/tree.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/rayman_1.ogg", "assets/music/rayman_1.ogg");
			type.set ("assets/music/rayman_1.ogg", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
