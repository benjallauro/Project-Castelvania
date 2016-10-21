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
	override public function create():Void
	{
		super.create();
		jack = new Player();
		add(jack);
		testEnemy = new Enemy();
		add(testEnemy);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.overlap(jack, testEnemy) && jack.getAttacking() == false)
			{
				jack.damage();
				
			}
		if (FlxG.overlap(testEnemy, jack) && jack.getAttacking() == true)
			testEnemy.damage();
	}
}
