package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState {
	override public function create():Void {
		FlxG.cameras.bgColor = 0xff75899C;
		#if !FLX_NO_MOUSE
		FlxG.mouse.load( "images/cursor.png", 3 );
		FlxG.mouse.show();
		#end
		
		FlxG.autoPause = false;
		
		var clickToPlay:FlxText = new FlxText( 0, 0, FlxG.width, "Click to Play" );
		clickToPlay.setFormat( "frucade" );
		clickToPlay.alignment = "center";
		clickToPlay.y = ( FlxG.height - clickToPlay.height ) / 2;
		add( clickToPlay );
		
		super.create();
	}
	
	override public function update():Void {
		if ( FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed ) {
			FlxG.switchState( new PlayState() );
		}
		
		super.update();
	}	
}