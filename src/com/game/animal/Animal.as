package com.game.animal 
{
	import com.game.GameEvents;
	import com.soundManager.SoundManager;
	import com.game.SceneData;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import treefortress.sound.SoundInstance;
	
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
		private var _idleOdds:int;
		//private var _soundManager:SoundManager;
		private var _snd:SoundInstance;
		private var _isActive:Boolean;
		private var _hasBeenClicked:Boolean
		
		public function Animal(clip:MovieClip, animalData:Object) 
		{
			//_soundManager = new SoundManager();
			_clip 				= clip;
			_clip.buttonMode 	= true;
			_clip.mouseChildren = false;
			_clip.addEventListener(MouseEvent.CLICK, handleObjectClicked);
			
			_animalData = animalData;
			_idleOdds 	= _animalData.idleOdds? _animalData.idleOdds:5;
			
			if (_animalData.idleWalk) initIdleWalk();
			_count = 1;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			_count++;
			if( _count % 30 == 0 ){
			var num:Number = Math.ceil(Math.random()*_idleOdds);
				if(num == 1 && _clip.currentFrame == 1){			
					_clip.gotoAndPlay("idle");
				}
			}
		}
		
		private function handleObjectClicked(e:MouseEvent):void 
		{
			if (!_isActive) 
			{
				_isActive = true;
				_hasBeenClicked = true;
				dispatchEvent( new GameEvents(GameEvents.ANIMAL_CLICKED) );
					// run/fly off screen if needed
				if (_animalData.runOffDirection) {
					runOffScreen();	
					// play object animation
					_clip.gotoAndStop("action");
				}else 
				{
					// play object animation
					_clip.gotoAndPlay("action");
					addEventListener(Event.ENTER_FRAME, checkActionDone);
				}
				
				// if this animal was walking, pause it
				if (_walkTM) {
					_walkTM.pause();
					addEventListener(Event.ENTER_FRAME, checkPause);
				}   
						
				// play object soundFX
				if (_animalData.soundData && _animalData.soundData.file != "") 
				{
					//_snd = _soundManager.playSound( { file: _animalData.soundData.file, loops: _animalData.soundData.loops, volume: _animalData.soundData.volume } );
					_snd = Main.SOUND_MANAGER.playSound( { file: _animalData.soundData.file, loops: _animalData.soundData.loops, volume: _animalData.soundData.volume } );
				}
			} 
			
			
		}		
		
		private function checkActionDone(e:Event):void 
		{
			if (_clip.currentFrameLabel == "endAction") 
			{
				_isActive = false;
				removeEventListener(Event.ENTER_FRAME, checkActionDone);
			}
		}
		
		private function checkPause(e:Event):void 
		{
			if ( _clip.currentFrameLabel == "endAction") {
				_clip.gotoAndPlay("idle");
				_walkTM.resume();
				removeEventListener(Event.ENTER_FRAME, checkPause);
				_isActive = false;
				removeEventListener(Event.ENTER_FRAME, checkActionDone);
			}
		}
		
		private function runOffScreen():void 
		{			
			var startX:Number = _clip.x;			
			var destX:Number =  _animalData.runOffDirection == SceneData.LEFT ? Main.OFF_SCREEN_LEFT - _clip.width:Main.OFF_SCREEN_RIGHT;
			var returnStartX:Number = _animalData.runOffDirection == SceneData.LEFT ? Main.OFF_SCREEN_RIGHT:Main.OFF_SCREEN_LEFT - _clip.width;
			
			// figure out speed of animal when it comes back on screen. 
			var secPerPixel:Number =_animalData.speed/ Math.abs(startX - destX) ;
			var returnSpeed:Number = Math.abs(startX - returnStartX) * secPerPixel;
			
			TweenMax.to( _clip, _animalData.speed, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreen, onCompleteParams:[startX, returnStartX, returnSpeed] } );
		}
		
		private function comeBackOnScreen( destX:Number, returnStartX:Number, speed:Number = 1):void 
		{
			_clip.gotoAndStop("action");
			_clip.x = returnStartX;
			TweenMax.to( _clip, speed, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreenDone, onCompleteParams: [_clip] } );
		}
		
		private function comeBackOnScreenDone(clip:MovieClip):void 
		{
			_isActive = false;
			_snd.pause();
			_clip.gotoAndStop("idle");
		}
		
		private function initIdleWalk():void 
		{
			var destX:Number =  _animalData.idleWalk.dir == SceneData.LEFT ?  Main.OFF_SCREEN_LEFT - _clip.width:Main.OFF_SCREEN_RIGHT;
			var returnStartX:Number =  _animalData.idleWalk.dir == SceneData.LEFT ? Main.OFF_SCREEN_RIGHT :Main.OFF_SCREEN_LEFT - _clip.width;
			_walkTM = new TimelineMax( {onComplete: loopIdleWalk, onCompleteParams:[_clip,returnStartX]} );
			_walkTM.add( TweenMax.to( _clip, _animalData.idleWalk.speed, { x: destX, ease:Linear.easeNone } ) );	
		}
		
		private function loopIdleWalk(params:Object, startX:Number):void 
		{
			_clip.x = startX;
			_walkTM.restart();
		}
		
		public function get hasBeenClicked():Boolean 
		{
			return _hasBeenClicked;
		}
		
	}

}