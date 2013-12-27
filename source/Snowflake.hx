package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

class Snowflake extends FlxSprite {
	private var wind:FlxPoint;
	
	public function new( X:Float, Y:Float ) {
		super( X, Y );
		makeGraphic( 1, 1 );
		wind = new FlxPoint( 0, 0 );
	}
	
	override public function update():Void {
		wind.x = 5 + (Reg.score * 0.025);
		
		if (wind.x >= 10) {
			wind.x = 10;
		}
		
		velocity.x = ( Math.cos(y / wind.x) * wind.x );
		
		if ( Reg.score == 0 ) {
			velocity.y = 15;
		} else {
			velocity.y = 5 + (Math.cos(y / 25) * 5) + wind.y;
		}
		
		if ( y > FlxG.height ) {
			kill();
		}
		
		super.update();
	}
}