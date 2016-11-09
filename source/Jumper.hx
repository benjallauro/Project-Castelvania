package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import Reg;

class Jumper extends FlxSprite
{
	var life:Int = 1;
	var direction:Bool = true;
	var distance:Bool = false; // cuando Jack esta cerca
	var jumpDone:Bool = false;

	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(25, 40, FlxColor.ORANGE);
		loadGraphic(AssetPaths.Eye__png, true, 22, 32);
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10, true);
		animation.play("idle");
		y = 300; // Siempre en 300.
		acceleration.y = 0;
		velocity.x = 0;
	}
	private function jump()
	{
		acceleration.y = 200;
		velocity.y = -300;
		jumpDone = true;
	}
	public function getY()
	{
		return y;
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
	public function startRunning()
	{
		if (x < (Reg.jackXPosition + (FlxG.width / 2) + width))
		{
			velocity.x = -60;
		}
	}
	public function hit()
	{
		x = x + 50;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (x < (Reg.jackXPosition + (FlxG.width / 2) - 30))
			distance = true;
		if (jumpDone == false && distance == true)
			jump();

			
		
	}
}