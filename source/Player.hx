package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
class Player extends FlxSprite
{
	var onAir:Bool = false;
	var jumpLimit:Float = 0;
	var zonaParado:Float = 0;
	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);	
		makeGraphic(25, 50, FlxColor.YELLOW);
		x = 300;
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		velocity.x = 0;
		if (FlxG.keys.pressed.RIGHT)
			velocity.x = 100;
		else if (FlxG.keys.pressed.LEFT)
			velocity.x = -100;
		chequearCaida();
	}
	
}