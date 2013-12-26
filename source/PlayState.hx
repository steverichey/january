package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState {
	private var _sky:FlxSprite;
	private var _mountain:FlxSprite;
	private var _backTrees:FlxSprite;
	private var _ground:FlxSprite;
	private var _trees:FlxSprite;
	
	override public function create():Void {
		#if !FLX_NO_MOUSE
		FlxG.mouse.hide();
		#end
		
		_sky = new FlxSprite(0, 0, "images/sky.png");
		_sky.velocity.x = -2;
		
		_mountain = new FlxSprite( FlxG.width - 70, 72, "images/mountain.png" );
		
		_backTrees = new FlxTilemap();
		_backTrees.y = 89;
		_backTrees.
		
		// Add everything to the state
		
		add( _sky );
		add( _mountain );
		
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}
	
	override public function update():Void {
		super.update();
	}	
}