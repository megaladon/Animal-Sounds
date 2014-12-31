package com.game.animal 
{
	import com.game.SceneData;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Animal extends MovieClip 
	{
		private var _clip:MovieClip;
		private var _animalData:Object;
		private var _walkTM:TimelineMax;
		private var _count:Number;
		
		public function Animal(clip:MovieClip, animalData:Object) 
		{
			_clip 				= clip;
			_clip.buttonMode 	= true;
			_clip.mouseChildren = false;
			_clip.addEventListener(MouseEvent.CLICK, handleObjectClicked);
			
			_animalData = animalData;
			
			if (_animalData.idleWalk) initIdleWalk();
			_count = 1;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			_count++;
			if( _count % 30 == 0 ){
			var num:Number = Math.ceil(Math.random()*5);
				if(num == 1 && _clip.currentFrame == 1){			
					_clip.gotoAndPlay("idle");
				}
			}
		}
		
		private function handleObjectClicked(e:MouseEvent):void 
		{
			
			// play object animation
			_clip.gotoAndPlay("action");
			
			// run/fly off screen if needed
			if (_animalData.runOffDirection) runOffScreen();		
			
			
			// Keith fix this. each object should have it's own timeline.
			if (_walkTM) {
				_walkTM.pause();
				addEventListener(Event.ENTER_FRAME, checkPause);
			}   
					
			// play object soundFX
				
		}		
		
		private function checkPause(e:Event):void 
		{
			if ( _clip.currentFrameLabel == "endAction") {
				_walkTM.resume();
				removeEventListener(Event.ENTER_FRAME, checkPause);
			}
		}
		
		private function runOffScreen():void 
		{			
			var startX:Number = _clip.x;
			var destX:Number =  _animalData.runOffDirection == SceneData.LEFT ? Main.OFF_SCREEN_LEFT - _clip.width:Main.OFF_SCREEN_RIGHT;
			TweenMax.to( _clip, 1.0, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreen, onCompleteParams:[_clip, startX, _animalData.runOffDirection] } );
		}
		
		private function comeBackOnScreen(clip:MovieClip, destX:Number, direction:String, frame:String = "action", speed:Number = 1):void 
		{
			_clip.gotoAndPlay(frame);
			var startX:Number = direction == SceneData.LEFT ? Main.OFF_SCREEN_RIGHT:Main.OFF_SCREEN_LEFT - _clip.width;
			_clip.x = startX;
			TweenMax.to( _clip, speed, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreenDone, onCompleteParams: [_clip] } );
		}
		
		private function comeBackOnScreenDone(clip:MovieClip):void 
		{
			_clip.gotoAndStop("idle");
		}
		
		private function initIdleWalk():void 
		{
			var destX:Number = Main.OFF_SCREEN_LEFT - _clip.width //  direction == SceneData.LEFT ? Main.OFF_SCREEN_LEFT - clip.width:Main.OFF_SCREEN_RIGHT;
			_walkTM = new TimelineMax( {onComplete: loopIdleWalk, onCompleteParams:[_clip]} );
			_walkTM.add( TweenMax.to( _clip, _animalData.idleWalk.speed, { x: destX, ease:Linear.easeNone } ) );	
		}
		
		private function loopIdleWalk(params:Object):void 
		{
			_clip.x = Main.OFF_SCREEN_RIGHT// - (Main.SCREEN_WIDTH/2);
			_walkTM.restart();
		}
		
	}

}