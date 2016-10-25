package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Sword extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(25, 15, FlxColor.BLUE);
		new FlxTimer().start(1.0, disappear, 1);
	}
	private function disappear(Timer:FlxTimer):Void
	{
		destroy();
	}
	public function setX(X:Float):Void
	{
		x = X;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		x = Reg.weaponXPosition;
		y = Reg.weaponYPosition;
	}
	
}