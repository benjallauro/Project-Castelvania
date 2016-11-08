package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import Reg;

class Enemy extends FlxSprite
{
	var life:Int = 1;
	var direction:Bool = true;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
	super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Nigro__png, true, 19, 23);
		//x = 230; y = 100;
		acceleration.y = 100;
		velocity.x = 0;
		animation.add("walk", [0, 1, 2], 4, true);
		animation.play("walk");
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
		kill();
	}
	private function movement()
	{
		if (x < Reg.jackXPosition && direction == true)
		{
			velocity.x = 25;
			flipX = true;
		}
		if (x > Reg.jackXPosition && direction == false)
		{
			velocity.x = 25;
			flipX = false;
			direction = true;
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
	}
	
}