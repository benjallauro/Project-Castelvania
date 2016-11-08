package;
import flixel.FlxG;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.FlxObject;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;//para cargar el nivel de ogmo
import flixel.tile.FlxTilemap;//para usarlo
import flixel.FlxObject;

class Reg
{
	static public var direction:Bool = false; //Esto indica cuando el personaje mira hacia la izquierda. De ser falso, mira hacia la derecha.
	static public var weaponXPosition:Float = 0;
	static public var weaponYPosition:Float = 0;
	static public var walkSpeed:Float = 50;
	static public var usingSword:Bool = false;
	static public var alive:Bool = true; //Esto me sirve para poder preguntar si Jack existe por mas que se haya destruido.
	static public var jackXPosition:Float = 0;
	static public var jackYPosition:Float = 0;
	static public var villians:FlxTypedGroup<Enemy>;
    static public var bats:FlxTypedGroup<Bat>;
	
}