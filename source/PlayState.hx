package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	var jack:Player;
	//var testEnemy:Enemy; //Temporal. Esto se quitara cuando se use el Ogmo.
	//var testBat:Bat;  //Temporal. Esto se quitara cuando se use el Ogmo.
	var theSword:Sword;
	private var floor:FlxTilemap;
	private var background:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var camara:FlxSprite;
	private var enemyKilled:FlxSound;
	private var backgroundMusic:FlxSound;

	
	
	
	override public function create():Void
	{
		super.create();
		
		jack = new Player();
		//testEnemy = new Enemy();
		//testBat = new Bat(250, 150); //Es necesario asignar X e Y. Aunque solo se enviara Y.
		//testBat.x = 250;
		Reg.villians = new FlxTypedGroup<Enemy>();
		Reg.bats = new FlxTypedGroup<Bat>();
		loader = new FlxOgmoLoader(AssetPaths.fuckinglevel__oel);
		floor = loader.loadTilemap(AssetPaths.Tiles__png, 16, 16, "tilesets");
		floor.immovable = true;
		background = loader.loadTilemap(AssetPaths.background__png, 16, 16, "background");
		add(background);
		add(floor);
		add(jack);
		//add(testEnemy);
		//add(testBat);
		add(Reg.villians);
		add(Reg.bats);
		
		camara = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		FlxG.camera.setScrollBounds(0, background.width, 0, background.height);
		
		FlxG.camera.follow(jack);

		FlxG.worldBounds.set(0, 0, background.width, background.height);
		
		loader.loadEntities(entityCreator, "entities");
		
		enemyKilled = new FlxSound();
		enemyKilled.loadEmbedded(AssetPaths.EnemyKilled__wav);
		enemyKilled.volume = 1;
		
		backgroundMusic = new FlxSound();
		backgroundMusic.loadEmbedded(AssetPaths.ProjectCastlevaniaTheme__wav);
		backgroundMusic.volume = 0.1;
		backgroundMusic.play();

	}
	
	private function entityCreator(entityName:String, entityData:Xml):Void
	{
		var entityStartX:Float = Std.parseFloat(entityData.get("x"));
		var entityStartY:Float = Std.parseFloat(entityData.get("y"));
		
		switch(entityName)
		{
			case "Enemy":
				    Reg.villians.add(new Enemy(entityStartX, entityStartY));
			case "Bat":
				    Reg.bats.add(new Bat(entityStartX, entityStartY));
		}

	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (Reg.alive == true) //Todo lo que se relaciona con jack ocurrira mientras exista. De esta forma no se lo llama cuando es destruido. Evitando que el programa crashe.
		{
			for (i in 0...Reg.villians.length)
			{
				if (FlxG.overlap(jack, Reg.villians.members[i]))
					{
						jack.damage();
					}
				if (FlxG.overlap(Reg.villians.members[i], theSword) && jack.getAttacking() == true)
				{
					Reg.villians.members[i].damage();
					enemyKilled.play();
				}
			}
			for (i in 0...Reg.bats.length)
			{
				 if (FlxG.overlap(jack, Reg.bats.members[i]))
					jack.damage();
				if (FlxG.overlap(Reg.bats.members[i], theSword)  && jack.getAttacking() == true)
					Reg.bats.members[i].damage();
			}
			if (FlxG.keys.justPressed.F || FlxG.keys.justPressed.SHIFT)
			{
				if ((jack.getAttacking() == false) && jack.exists)
				{
					jack.startAttack();
				}
			}
			if (jack.animation.name == "attack")
				{
					if(jack.animation.finished)
						jack.stopAttack();
					else if (jack.animation.frameIndex == 6)
					{
						if(Reg.usingSword == false){
							theSword = new Sword();
							Reg.usingSword = true;
						}
						if (Reg.direction == false)
						{
							theSword.setPosition(Reg.weaponXPosition, Reg.weaponYPosition);
							theSword.flipX = true;
							add(theSword);
						}
						else
						{
							theSword.setPosition(Reg.weaponXPosition, Reg.weaponYPosition);
							theSword.flipX = false;
							add(theSword);
						}
						
					}
			}
			if (Reg.direction == false)
			{
				Reg.weaponXPosition = (jack.getX() + jack.width + 4.5);
				Reg.weaponYPosition = ((jack.getY()) + 6.5);
				Reg.jackXPosition = jack.x;
			}
			if (Reg.direction == true)
			{
				Reg.weaponXPosition = (jack.getX() - jack.width - 4.5);
				Reg.weaponYPosition = ((jack.getY()) + 6.5);
				Reg.jackXPosition = jack.x;
			}
			FlxG.collide(floor, jack);

		}
		if (Reg.alive == false)
		jack.destroy();
		
		for (i in 0...Reg.villians.length)
		{
			FlxG.collide(floor, Reg.villians.members[i]);
			if (Reg.villians.members[i].x < (Reg.jackXPosition + (FlxG.width/2)))
				Reg.villians.members[i].velocity.x = -25;
				
		}
		for (i in 0...Reg.bats.length)
		{
			if (Reg.bats.members[i].x < (Reg.jackXPosition + (FlxG.width/2)))
				Reg.bats.members[i].velocity.x = -25;
		}
	}
}