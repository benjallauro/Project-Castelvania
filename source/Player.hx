package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	var life:Int = 3;
	var attacking:Bool = false;
	var flinch:Bool = false;
	var flinchTime:FlxTimer = new FlxTimer();
	private var jumpSound:FlxSound;
	private var hurtSound:FlxSound;

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
		animation.add("walk", [1, 2, 3], 7, true);
		animation.add("damage", [11, 11], 1, false);
		animation.play("idle");
		jumpSound = new FlxSound();
		jumpSound.loadEmbedded(AssetPaths.jumpSound__wav);
		jumpSound.volume = 0.5;
		hurtSound = new FlxSound();
		hurtSound.loadEmbedded(AssetPaths.Hurt__wav);
		hurtSound.volume = 1;
	}

	public function damage()
	{
		life--;
		x = x - 50;
		
		flinch = true;
		attacking = false;
		animation.play("damage");
		flinchTime.start(0.2, canMove, 1);
		hurtSound.play();
		if (life <= 0)
			death();
	}
	private function canMove(Timer:FlxTimer)
	{
		flinch = false;
	}
	public function death()
	{
		//destroy();
		Reg.alive = false;
		hurtSound.play();
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
		if (FlxG.keys.pressed.RIGHT && (flinch == false))
		{
			velocity.x = Reg.walkSpeed;
			Reg.direction = false;
			flipX = true;
		if(attacking == false)
			animation.play("walk");
		}
		if (FlxG.keys.pressed.LEFT && (flinch == false))
		{
			velocity.x = -(Reg.walkSpeed);
			Reg.direction = true;
			flipX = false;
			if(attacking == false)
				animation.play("walk");
		}
		else if ((FlxG.keys.pressed.RIGHT == false) && (FlxG.keys.pressed.LEFT == false) && (attacking == false) && (flinch == false))
		{
			animation.play("idle");
		}
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -100;
			jumpSound.play();
		}
		if (y > 300)
		death();
		
		super.update(elapsed);
		
	}
	
}