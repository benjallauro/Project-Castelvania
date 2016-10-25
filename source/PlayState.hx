package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	var jack:Player;
	var testEnemy:Enemy; //Temporal. Esto se quitara cuando se use el Ogmo.
	var theSword:Sword;
	
	override public function create():Void
	{
		super.create();
		jack = new Player();
		add(jack);
		testEnemy = new Enemy();
		add(testEnemy);
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
				theSword = new Sword();
				jack.startAttack();
				if(Reg.direction == false)
					theSword.setPosition((jack.x + jack.width), jack.y)
				else
					theSword.setPosition(jack.x, jack.y);
				add(theSword);
			}	
		}
		if (Reg.direction == false)
		{
			Reg.weaponXPosition = (jack.getX() + jack.width);
			Reg.weaponYPosition = (jack.getY());
		}
		if (Reg.direction == true)
		{
			Reg.weaponXPosition = (jack.getX() - jack.width);
			Reg.weaponYPosition = (jack.getY());
		}
	}
}