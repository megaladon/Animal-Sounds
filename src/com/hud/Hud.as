package com.hud 
{
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Hud extends MovieClip 
	{
		private var _nextScene_Btn:MovieClip;
		private var _hudActive:Boolean;
		private var _promptTimer:Timer;
		
		public function Hud() 
		{
			// Init next scene button
			_nextScene_Btn = new nextSceneButton();
			_nextScene_Btn.x = 0;
			_nextScene_Btn.y = 0;
			_nextScene_Btn.addEventListener(MouseEvent.MOUSE_UP, onNextScene);
			_nextScene_Btn.addEventListener(MouseEvent.MOUSE_DOWN, onHiliteButton);
			_nextScene_Btn.buttonMode = true;
			addChild(_nextScene_Btn);	
			
			
			_promptTimer = new Timer(30000,1)
			_promptTimer.addEventListener(TimerEvent.TIMER_COMPLETE, promptTimerDone);		
			hideHud();
		}
		
		private function onHiliteButton(e:MouseEvent):void 
		{
			if (_hudActive) {		
				Main.hiliteClip(_nextScene_Btn);
			}
		}
		
		public function promptNextScene():void 
		{
			_nextScene_Btn.gotoAndStop("prompt")
		}
		
		private function onNextScene(e:MouseEvent):void 
		{
			if (_hudActive) {
				dispatchEvent( new HudEvents(HudEvents.NEXT_SCENE_BUTTON_CLICKED) );
				hideHud();
				Main.unHiliteClip(_nextScene_Btn);
			}
		}		
		
		public function hideHud():void 
		{
			_hudActive = false;
			_nextScene_Btn.alpha = 0;
			_nextScene_Btn.gotoAndStop(1)
			_promptTimer.reset();
		}
		
		public function showHud():void 
		{
			TweenMax.to( _nextScene_Btn, .3, { alpha:1, ease:Linear.easeNone, onComplete: hudReady } );
			_promptTimer.start();
		}
		
		private function promptTimerDone(e:TimerEvent):void 
		{
			if (_nextScene_Btn.currentFrame == 1) promptNextScene();
		}
		
		private function hudReady():void 
		{
			_hudActive = true;
		}
	}

}