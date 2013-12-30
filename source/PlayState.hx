package;

import flash.display.BitmapData;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

class PlayState extends FlxState {
	public var autoPilot:Bool = false;
	public var autoPilotMovement:String = "";
	public var spawnRate:Float = SHOWER;
	
	private var _sky:FlxSprite;
	private var _mountain:FlxSprite;
	private var _backTrees:FlxTilemap;
	private var _ground:FlxSprite;
	private var _trees:FlxSprite;
	private var _player:Player;
	private var _snow:FlxTypedGroup<Snowflake>;
	private var _snowTimer:FlxTimer;
	
	inline static private var BLIZZARD:Float = 0.050;
	inline static private var SHOWER:Float = 0.250;
	inline static private var FLURRY:Float = 1.0;
	
	override public function create():Void {
		#if !FLX_NO_MOUSE
		FlxG.mouse.hide();
		#end
		
		Reg.PS = this;
		
		FlxG.worldBounds.set( 0, 0, FlxG.width, FlxG.height );
		
		FlxG.sound.volume = 1;
		FlxG.sound.playMusic( "ambience" );
		FlxG.sound.music.fadeIn( 2 );
		
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
		
		_trees = new FlxSprite( 0, FlxG.height - 27, "images/trees.png" );
		
		_player = new Player();
		
		_snow = new FlxTypedGroup<Snowflake>( 1000 );
		_snowTimer = FlxTimer.recycle();
		_snowTimer.run( spawnRate, spawnFlake, 0 );
		
		// Add everything to the state
		
		add( _sky );
		add( _mountain );
		add( _backTrees );
		add( _ground );
		add( _trees );
		add( _player );
		add( _snow );
		
		super.create();
	}
	
	override public function update():Void {
		// Loop sky background
		
		if ( _sky.x < -716 ) {
			_sky.x = 0;
		}
		
		// Collision check
		
		if ( _player.tongueUp ) {
			FlxG.overlap( _snow, _player, onLick );
		}
		
		#if debug
		if ( FlxG.keys.justReleased.R ) {
			FlxG.resetState();
		}
		#end
		
		super.update();
	}
	
	private function spawnFlake( t:FlxTimer ):Void {
		var flakeX:Int = FlxRandom.intRanged( 0, FlxG.width );
		var flakeY:Int = 0;
		var flake:Snowflake = _snow.recycle( Snowflake, [ flakeX, flakeY ] );
		flake.reset( flakeX, flakeY );
	}
	
	private function onLick( Snow:FlxObject, PlayerObject:FlxObject ) {
		Snow.kill();
	}
	
	override public function destroy():Void {
		super.destroy();
	}
}