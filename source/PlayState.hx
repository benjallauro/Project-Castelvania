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

class PlayState extends FlxState
{
	var jack:Player;
	var testEnemy:Enemy; //Temporal. Esto se quitara cuando se use el Ogmo.
	var theSword:Sword;
	
	var platform:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		jack = new Player();
		add(jack);
		testEnemy = new Enemy();
		add(testEnemy);
		platform = new FlxSprite(0, 200);
		platform.makeGraphic(FlxG.width, 16, 0xFF00FFFF);
		platform.immovable = true;
		add(platform);
	}
//theSword.setPosition(jack.x, jack.y);
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.overlap(jack, testEnemy))
			{
				jack.damage();
				
			}
		if (FlxG.overlap(testEnemy, theSword) && jack.getAttacking() == true)
			testEnemy.damage();
		if (FlxG.keys.justPressed.F)
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
					theSword = new Sword();
					if (Reg.direction == false)
					{
						theSword.setPosition((jack.x + jack.width), jack.y + 5);
						add(theSword);
					}
					else
					{
						theSword.setPosition(jack.x, jack.y + 5);
						add(theSword);
					}
					
				}
		}
		if (Reg.direction == false)
		{
			Reg.weaponXPosition = (jack.getX() + jack.width);
			Reg.weaponYPosition = ((jack.getY()) + 5);
		}
		if (Reg.direction == true)
		{
			Reg.weaponXPosition = (jack.getX() - jack.width);
			Reg.weaponYPosition = ((jack.getY()) + 5);
		}
		

		FlxG.collide(platform, jack);
		FlxG.collide(platform, testEnemy);
	}
}