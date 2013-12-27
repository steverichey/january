package;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.util.FlxSave;

class Reg
{
	static public var PS:PlayState;
	static public var score:Int;
	
	inline static private function GROUND_COLORS():Array<Int> {
		return [ 0xffFAFAFA, 0xffF7F7F7, 0xffF2F2F2 ];
	}
	
	static public function addNoiseTo( PlainSprite:FlxSprite, FromY:Int, PixelsPerSquare:Int = 12 ):Void {
		var bitmapdata:BitmapData = new BitmapData( 1, 1, false, GROUND_COLORS()[0] );
		var noiseAmount:Int = Std.int( 12 * PlainSprite.width / 16 );
		
		for ( color in GROUND_COLORS() ) {
			for ( i in 0...noiseAmount ) {
				PlainSprite.pixels.draw( 	new BitmapData( 1, 1, false, color ), 
											new Matrix( 1, 0, 0, 1, 
												FlxRandom.intRanged( 0, Std.int( PlainSprite.width ) ), 
												FlxRandom.intRanged( FromY, Std.int( PlainSprite.height ) ) ) );
			}
		}
	}
	
	static public function drawMountain():Sprite {
		var sprite:Sprite = new Sprite();
		
		sprite.graphics.beginFill( 0xffCDD5D7 );
		sprite.graphics.moveTo( 0, 24 );
		sprite.graphics.lineTo( FlxRandom.intRanged( 2, 5 ), FlxRandom.intRanged( 21, 23 ) );
		sprite.graphics.lineTo( FlxRandom.intRanged( 38, 42 ), FlxRandom.intRanged( 5, 9 ) );
		sprite.graphics.lineTo( FlxRandom.intRanged( 44, 47 ), FlxRandom.intRanged( 0, 3 ) );
		sprite.graphics.lineTo( FlxRandom.intRanged( 56, 60 ), FlxRandom.intRanged( 4, 5 ) );
		sprite.graphics.lineTo( FlxRandom.intRanged( 64, 67 ), FlxRandom.intRanged( 8, 10 ) );
		sprite.graphics.lineTo( FlxRandom.intRanged( 88, 92 ), FlxRandom.intRanged( 18, 20 ) );
		sprite.graphics.lineTo( 105, 24 );
		sprite.graphics.endFill();
		
		return sprite;
	}
}