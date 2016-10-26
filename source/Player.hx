package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
class Player extends FlxSprite
{
	var life:Int = 10;
	var attacking: Bool = false;
	

	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);	
		makeGraphic(15, 30, FlxColor.YELLOW);
		x = 100;
		y = 150;
		acceleration.y = 150;
	}

	public function damage()
	{
		life--;
		x = x - 50;
		if (life <= 0)
			death();
	}
	private function death()
	{
		destroy();
	}
	public function startAttack()
	{
		
		makeGraphic(15, 30, FlxColor.RED);
		attacking = true;
		
		new FlxTimer().start(1.0, stopAttack, 1);
	}
	private function stopAttack(Timer:FlxTimer):Void
	{
		makeGraphic(15, 30, FlxColor.YELLOW);
		attacking = false;
	}
	public function getAttacking():Bool
	{
		return attacking;
	}
	public function getX():Float
	{
		return x;
	}
	public function getY():Float
	{
		return y;
	}
	override public function update(elapsed:Float):Void
	{
		
		velocity.x = 0;
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = Reg.walkSpeed;
			Reg.direction = false;
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -(Reg.walkSpeed);
			Reg.direction = true;
		}
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
			velocity.y = -100;
		//chequearCaida();
		super.update(elapsed);
		
	}
	
}