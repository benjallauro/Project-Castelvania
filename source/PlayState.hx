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
		if (Reg.alive == true) //Todo lo que se relaciona con jack ocurrira mientras exista. De esta forma no se lo llama cuando es destruido. Evitando que el programa crashe.
		{
			if (FlxG.overlap(jack, testEnemy))
				{
					jack.damage();
				
				}
			if (FlxG.overlap(testEnemy, theSword) && jack.getAttacking() == true)
				testEnemy.damage();
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
			}
			if (Reg.direction == true)
			{
				Reg.weaponXPosition = (jack.getX() - jack.width - 4.5);
				Reg.weaponYPosition = ((jack.getY()) + 6.5);
			}
			FlxG.collide(platform, jack);
			
		}
		if (Reg.alive == false)
		jack.destroy();
		
		FlxG.collide(platform, testEnemy);
	}
}