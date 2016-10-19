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
	override public function create():Void
	{
		super.create();
		jack = new Player();
		add(jack);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
