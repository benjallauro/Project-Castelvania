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
	var attacking:Bool = false;
	

	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);	
		loadGraphic(AssetPaths.FullAnimationPlayer__png, true, 80, 64);
		setSize(15, 30);
		centerOffsets();
		offset.y += 15;
		x = 100;
		y = 100;
		acceleration.y = 150;
		animation.add("idle", [0, 0], 1, false);
		animation.add("attack", [4, 5, 6], 4, false);
		animation.play("idle");
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
		animation.play("attack");
		attacking = true;
	}
	public function stopAttack():Void
	{
		attacking = false;
		animation.play("idle");
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
			//if (Reg.direction = true)
			flipX = true;
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -(Reg.walkSpeed);
			Reg.direction = true;
			//if (Reg.direction = false)
			flipX = false;
		}
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
			velocity.y = -100;
		
		
			
		
		super.update(elapsed);
		
	}
	
}