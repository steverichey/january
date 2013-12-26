package;

import flash.display.BitmapData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

class PlayState extends FlxState {
	private var _sky:FlxSprite;
	private var _mountain:FlxSprite;
	private var _backTrees:FlxTilemap;
	private var _ground:FlxSprite;
	private var _trees:FlxTilemap;
	
	override public function create():Void {
		#if !FLX_NO_MOUSE
		FlxG.mouse.hide();
		#end
		
		FlxG.watch.add( FlxG.mouse, "x" );
		
		_sky = new FlxSprite(0, 0, "images/sky.png");
		_sky.velocity.x = -2;
		
		_mountain = new FlxSprite( FlxG.width - 70, FlxG.height - 38 );
		_mountain.makeGraphic( 105, 24, 0 );
		_mountain.pixels.draw( Reg.drawMountain() );
		
		_backTrees = new FlxTilemap();
		_backTrees.y = FlxG.height - 21;
		_backTrees.widthInTiles = 30;
		_backTrees.heightInTiles = 1;
		
		var treeArray:Array<Int> = new Array<Int>();
		
		for ( i in 0...30 ) {
			treeArray.push( FlxRandom.intRanged( 1, 17 ) );
		}
		
		_backTrees.loadMap( treeArray, "images/backtrees.png" );
		
		_ground = new FlxSprite( 0, FlxG.height - 13 );
		_ground.makeGraphic( FlxG.width, 13 );
		_ground.pixels.draw( new BitmapData( FlxG.width, 2, false, 0xffFCFCFC ) );
		Reg.addNoiseTo( _ground, 2 );
		
		_trees = new FlxTilemap();
		//_triees.loadMap(
		_trees.y = FlxG.height - 23;
		
		// Add everything to the state
		
		add( _sky );
		add( _mountain );
		add( _backTrees );
		add( _ground );
		
		super.create();
	}
	
	override public function update():Void {
		#if debug
		if ( FlxG.keys.justReleased.R ) {
			FlxG.resetState();
		}
		#end
		
		super.update();
	}
	
	
	override public function destroy():Void {
		super.destroy();
	}
}