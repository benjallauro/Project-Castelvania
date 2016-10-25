package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
class Player extends FlxSprite
{
	var onAir:Bool = false;
	var jumpLimit:Float = 0;
	var zonaParado:Float = 0;
	var life:Int = 10;
	var attacking: Bool = false;
	

	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);	
		makeGraphic(25, 50, FlxColor.YELLOW);
		x = 100;
		y = 300;
		zonaParado = y + height;
		
	}
	private function chequearCaida() //Como recien vamos a aprender este tema la semana que viene, hice una reemplazo de sistema de salto y caida. Es temporal.
	{
		if (FlxG.keys.pressed.UP && onAir == false && y > jumpLimit)
			velocity.y = -300;
		else if (y < zonaParado - height)
		{
			velocity.y = 300;
			onAir = true;
		}
		else if (y == (zonaParado - height))
		{
			velocity.y = 0;
			onAir = false;
			jumpLimit = y - (height * 2);
		}
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
	private function startAttack()
	{
		
		makeGraphic(25, 50, FlxColor.RED);
		attacking = true;
		
		new FlxTimer().start(1.0, stopAttack, 1);
	}
	private function stopAttack(Timer:FlxTimer):Void
	{
		makeGraphic(25, 50, FlxColor.YELLOW);
		//theSword.destroy();
		attacking = false;
	}
	public function getAttacking():Bool
	{
		return attacking;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		velocity.x = 0;
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = 100;
			Reg.direction = false;
		}
		else if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -100;
			Reg.direction = true;
		}
		chequearCaida();
		if (FlxG.keys.justPressed.F)
		{
			startAttack();
			
		}
	}
	
}