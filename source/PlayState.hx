package;

import objects.*;
import flixel.*;
import flixel.text.*;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState {

	var planet : Planet;
	var player : Player;

	var backgroundAnimation : BackgroundAnimation;

	var tileChain : TileChain;

	var scoreText : FlxText;

	var iceBalls : Array<IceBall>;

	var penguins : Array<Penguin>;

	// Tutorial stuff
	var tutorialText : FlxText;
	var tutorialStrs : Array<String>;
	var	tutorialState : Int;
	var tutorialTimer : FlxTimer;

	override public function create() : Void {

		// Add the background animation
		backgroundAnimation = new BackgroundAnimation();
		add(backgroundAnimation);

		// Add the planet
		planet = new Planet();
		add(planet);

		// Add the tile chain
		tileChain = new TileChain();
		add(tileChain);

		// Add the ice balls
		iceBalls = new Array<IceBall>();
		for (i in 0...9) {
			iceBalls.push(new IceBall());
			iceBalls[i].rotateTime = i/10.0;
			add(iceBalls[i]);
		}

		// Add the penguins
		penguins = new Array<Penguin>();
		for (i in 0...2) {
			penguins.push(new Penguin());
			penguins[i].rotateTime = i;
			add(penguins[i]);
		}

		// Add the player
		player = new Player();
		add(player);

		// Add the score text
		scoreText = new FlxText();
		scoreText.text = "Score : " + Main.SCORE;
		scoreText.size = 25;
		scoreText.x = FlxG.width - scoreText.getHitbox().width - 10;
		scoreText.color = FlxColor.YELLOW;
		add(scoreText);

		// Set the tutorials map
		tutorialStrs = new Array<String>();
		tutorialStrs.push("You can jump pressing space or up button !\n\t~With precision please !~");
		tutorialStrs.push("To be faster press right...");
		tutorialStrs.push("Or slower press left...");
		tutorialStrs.push("Oh crap : penguin !");
		tutorialStrs.push("Jump on the penguin to hit him\n(Press down to be more powerful)");
		tutorialStrs.push("Good luck now !");

		// Set the tutorial state to zero
		tutorialState = -1;

		// Add the tutorial timer
		tutorialTimer = new FlxTimer();

		// Add the tutorial text
		tutorialText = new FlxText();
		tutorialText.text = "";
		tutorialText.size = 25;
		tutorialText.color = FlxColor.RED;
		add(tutorialText);

		// Call HaxeFlixel state creator
		super.create();

	}

	override public function update(elapsed : Float) : Void {
		
		// A loose variable, for the song don't play again
		var lose = false;

		// Set speed + player speed
		var lastSpeed = Main.SPEED;
		Main.SPEED += player.speed;

		// Update state
		super.update(elapsed);

		// For tutorial
		if (tutorialState < tutorialStrs.length+1 && tutorialState != -1) {
			if (tutorialState < 6)
				tutorialText.text = tutorialStrs[tutorialState];
			else
				tutorialText.text = "";
			tutorialText.x = (FlxG.width - tutorialText.getHitbox().width) / 2;
			tutorialText.y = (FlxG.height - tutorialText.getHitbox().height) / 2;
		}

		switch(tutorialState) {
			case -1:
				for (t in tileChain.tiles)
					if (t.visible)
						if (t.getPosition().distanceTo(player.getPosition()) < 250) {
							tutorialState++;
							tutorialTimer.start(3000.0);
							break;
						}

			case 0:
				if (tutorialTimer.elapsedTime >= 3.0) {
					tutorialTimer.reset();
					tutorialTimer.start(3000.0);
					tutorialState++;
				}

			case 1:
				if (tutorialTimer.elapsedTime >= 3.0) {
					tutorialTimer.reset();
					tutorialState++;
				}

			case 2:
				for (p in penguins)
					if (p.getPosition().distanceTo(player.getPosition()) < 300) {
						tutorialState++;
						break;
					}

			case 3:
				for (p in penguins)
					if (p.getPosition().distanceTo(player.getPosition()) < 150) {
						tutorialState++;
						tutorialTimer.start(4000.0);
						break;
					}

			case 4:
				if (tutorialTimer.elapsedTime >= 4.0) {
					tutorialTimer.reset();
					tutorialTimer.start(3000.0);
					tutorialState++;
				}
			
			case 5:
				if (tutorialTimer.elapsedTime >= 3.0) {
					tutorialTimer.reset();
					tutorialState++;
				}
				
		}

		// Check collison between player & planet
		if (FlxG.collide(planet, player))
			player.onGround = true;
		else
			player.onGround = false;

		// Check collision between player & tiles
		if (tileChain.playerCollides(player)) {

			FlxG.sound.music.stop();

			player.frozeAndDie();

			planet.active = false;
			player.active = false;

			backgroundAnimation.active = false;

			tileChain.active = false;

			scoreText.active = false;

			for (ib in iceBalls)
				ib.active = false;

			tileChain.active = false;

			FlxG.camera.fade(FlxColor.BLACK, 0.40, false, function() {
								FlxG.switchState(new GameOverState());
							});
			lose = true;
		}

		// Update ice balls
		var outBalls : Int = 0;
		for (ib in iceBalls) {
			if (!ib.isOnScreen(null))
				outBalls++;
			else
				if (player.overlaps(ib) && ib.visible) {
					Main.ICE_BALLS++;
					ib.visible = false;
					player.eat();
				}
		}

		if (outBalls == iceBalls.length) {
			var speed = new FlxRandom().int(1, 8)/10.0;
			for (ib in iceBalls) {
				ib.speed = speed;
				ib.visible = true;
			}
		} else {
			for (ib in iceBalls)
				ib.speed = 1.0;
		}

		// Update penguins
		for (p in penguins) {
			// Check if the player jumped on penguins
			p.globalSpeed = lastSpeed - player.speed;
			if (!p.dying) {
				if (p.x >= FlxG.width / 2 - 75 && p.x <= FlxG.width / 2 + 75) {
					if (player.y+player.height/1.5 <= p.y && !player.onGround && player.velocity.y > 0) {
						if (FlxG.pixelPerfectOverlap(player, p)) {
							p.die();
							Main.SCORE += 15;
						}
					} else {
						if (FlxG.pixelPerfectOverlap(player, p)) {

							FlxG.sound.music.stop();

							player.frozeAndDie();

							planet.active = false;
							player.active = false;

							backgroundAnimation.active = false;

							tileChain.active = false;

							scoreText.active = false;

							for (ib in iceBalls)
								ib.active = false;

							tileChain.active = false;

							FlxG.camera.fade(FlxColor.BLACK, 0.40, false, function() {
								FlxG.switchState(new GameOverState());
							});

							lose = true;
						}
					}
				}
			}
		}

		// Update the score & score text
		Main.SCORE += Std.int((1.0/8.0) * Main.SPEED);
		scoreText.text = "Ice Balls : " + Main.ICE_BALLS + "\t\t\tScore : " + Main.SCORE;
		scoreText.x = FlxG.width - scoreText.getHitbox().width - 10;

		// Set planet y
		Main.PLANET_Y = planet.y;

		// Update speed
		if (Main.SPEED < 18)
			Main.SPEED += 0.001 + player.speed;

		// Play & update music
		if (!lose)
			if (FlxG.sound.music == null || !FlxG.sound.music.playing) 
				FlxG.sound.playMusic(AssetPaths.rayman_1__ogg, 1.0, true);

		// Set speed - player speed
		Main.SPEED = lastSpeed + ((Main.SPEED < 18) ? 0.001 : 0.0);
	}

}