package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class PlayState extends FlxState
{
	var jack:Player;
	var testEnemy:Enemy; //Temporal. Esto se quitara cuando se use el Ogmo.
	var testBat:Bat;  //Temporal. Esto se quitara cuando se use el Ogmo.
	var theSword:Sword;
	private var floor:FlxTilemap;
	private var background:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var camara:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		
		loader = new FlxOgmoLoader(AssetPaths.fuckinglevel__oel);
		floor = loader.loadTilemap(AssetPaths.Tiles__png, 16, 16, "tilesets");
		floor.immovable = true;
		background = loader.loadTilemap(AssetPaths.background__png, 16, 16, "background");
		
		add(background);
		add(floor);
		
		jack = new Player();
		add(jack);
		testEnemy = new Enemy();
		add(testEnemy);
		testBat = new Bat(250, 150); //Es necesario asignar X e Y. Aunque solo se enviara Y.
		testBat.x = 250;
		add(testBat);
		
		camara = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		FlxG.camera.setScrollBounds(0, background.width, 0, background.height);

		FlxG.worldBounds.set(0, 0, background.width, background.height);
	}
//theSword.setPosition(jack.x, jack.y);
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (Reg.alive == true) //Todo lo que se relaciona con jack ocurrira mientras exista. De esta forma no se lo llama cuando es destruido. Evitando que el programa crashe.
		{
			if (FlxG.overlap(jack, testEnemy) || FlxG.overlap(jack, testBat))
				{
					jack.damage();
				
				}
			if (FlxG.overlap(testEnemy, theSword) && jack.getAttacking() == true)
				testEnemy.damage();
			if (FlxG.overlap(testBat, theSword)  && jack.getAttacking() == true)
				testBat.damage();
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
		
		FlxG.collide(floor, testEnemy);
		camara.x = Reg.jackXPosition;
	}
}