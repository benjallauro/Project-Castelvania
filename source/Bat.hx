package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class Bat extends FlxSprite
{
	var up:FlxTimer = new FlxTimer();
	var down:FlxTimer = new FlxTimer();
	var toptop:Float;
	var bottom:Float;
	var life:Int = 1;
	
	public function new(?X:Float=0, Y:Float, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(10, 10, FlxColor.PURPLE);
		velocity.x = -15;
		velocity.y = 50;
		toptop = y - 15;
		bottom = y + 15;
	}
	public function damage()
	{
		life--;
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
		if (y <= toptop)
			velocity.y = 50;
		if (y >= bottom)
			velocity.y = -50;
		
	}
}