package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

class Enemy extends FlxSprite
{
	var life:Int = 5;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(25, 45, FlxColor.ORANGE);
		x = 200; y = 300;
	}
	public function damage()
	{
		life--;
		x = x + 50;
		if (life <= 0)
			death();
	}
	private function death()
	{
		destroy();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}