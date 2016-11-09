package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import Reg;

class Runner extends FlxSprite
{
	var life:Int = 1;
	var direction:Bool = true;
	var jumpReady:Bool = true;
	var running:Bool = false;
	var jumpTimer:FlxTimer = new FlxTimer();
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.TurboKnight__png, true, 37, 27);
		animation.add("run", [0, 1, 2, 3], 10, true);
		animation.play("run");
		acceleration.y = 100;
		velocity.x = 0;

	}
	public function jumpCounter()
	{
		if (jumpReady == true && running == true)
		{
			jumpReady = false;
			jumpTimer.start(0.3, jump, 1);
		}
	}
	public function startRunning()
	{
		if (x < (Reg.jackXPosition + (FlxG.width / 2) + width))
		{
			running = true;
			velocity.x = -60;
		}
	}
	public function hit()
	{
		x = x + 50;
	}
	private function jump(Timer:FlxTimer)
	{
		velocity.y = -50;
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		startRunning();
	}
}