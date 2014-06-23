package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class Player extends FlxSprite {
	/**
	 * Whether or not the player had their tongue up as of the last frame.
	 */
	public var tongueUp:Bool = false;
	
	/**
	 * Whether or not the player has just stopped.
	 */
	private var stopped:Bool = false;
	
	inline static private var X_INIT:Int = 20;
	inline static private var Y_INIT:Int = 79;
	
	public function new() {
		super( X_INIT, Y_INIT );
		loadGraphic( "images/player.png", true, 16, 33 );
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		width = 10;
		height = 3;
		offset.x = 4;
		offset.y = 7;
		
		animation.add( "idle", [78, 79, 80, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 6, false );
		animation.add( "tongueUpStopped", [73, 74, 75, 76, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5], 6, false );
		animation.add( "tongueUp", [2, 3, 4, 5], 18, false );
		animation.add( "tongueDown", [4, 3, 2, 0], 18, false);
		animation.add( "walk", [33, 35, 37, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31], 12);
		animation.add( "walkTongue", [66, 68, 70, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64], 12);
		animation.play( "idle" );
	}
	
	override public function update():Void {
		acceleration.x = 0;
		
		// Player speed
		
		if ( isSlowFrame( animation.frameIndex ) ) {
			maxVelocity.x = 20;
		} else {
			maxVelocity.x = 40;
		}
		
		if ( FlxG.keys.pressed.CONTROL ) {
			maxVelocity.x = 80;
		}
		
		// Input
		
		if ( FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A || ( Reg.PS.autoPilot && Reg.PS.autoPilotMovement == "left" ) ) {
			facing = FlxObject.LEFT;
			//Snowflake.timbre = "Secondary";
			velocity.x = -maxVelocity.x;
		} else if ( FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D || ( Reg.PS.autoPilot && Reg.PS.autoPilotMovement == "right" ) ) {
			facing = FlxObject.RIGHT;
			//Snowflake.timbre = "Primary";
			velocity.x = maxVelocity.x;
		} else if ( FlxG.keys.anyJustReleased( [ "LEFT", "RIGHT", "A", "D" ] ) || ( Reg.PS.autoPilot && Reg.PS.autoPilotMovement == "still" ) ) {
			drag.x = 100;
			stopped = true;
		}
		
		// Animation
		
		if ( velocity.x != 0 ) {
			if ( tongueUp ) {
				animation.play( "walkTongue" );
			} else {
				animation.play( "walk" );
			}
			
			if ( FlxG.keys.anyPressed( [ "UP", "W" ] ) ) {
				tongueUp = true;
			} else if ( FlxG.keys.anyPressed( [ "DOWN", "S" ] ) ) {
				tongueUp = false;
			}
		} else {
			if ( tongueUp && FlxG.keys.anyPressed( [ "DOWN", "S" ] ) ) {
				animation.play( "tongueDown" );
				tongueUp = false;
			} else if ( !tongueUp && FlxG.keys.anyPressed( [ "UP", "W" ] ) ) {
				animation.play( "tongueUp" );
				tongueUp = true;
			}
			
			if ( stopped ) {
				if ( tongueUp ) {
					animation.play( "tongueUpStopped" );
				} else {
					animation.play( "idle" );
				}
			}
		}
		
		super.update();
		
		if ( x < -width ) {
			x = FlxG.width;
		} else if ( x > FlxG.width ) {
			x = -width;
		}
	}
	
	/**
	 * Determine if this frame is a "slow" frame. The variation in maxVelocity creates a natural walking rhythm.
	 * 
	 * @param	FrameIndex	The index of the frame to check.
	 * @return	Whether or not the maxVelocity cap should be low.
	 */
	private function isSlowFrame( FrameIndex:Int ):Bool {
		var isSlow:Bool = false;
		
		if ( 	( FrameIndex >= 11 && FrameIndex <= 14 ) || 
				( FrameIndex >= 27 && FrameIndex <= 31 ) || 
				( FrameIndex >= 44 && FrameIndex <= 47 ) || 
				( FrameIndex >= 60 && FrameIndex <= 64 ) ) {
			isSlow = true;
		}
		
		return isSlow;
	}
}