package com.hud 
{
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Hud extends MovieClip 
	{
		private var _nextScene_Btn:MovieClip;
		private var _hudActive:Boolean;
		
		public function Hud() 
		{
			// Init next scene button
			_nextScene_Btn = new nextSceneButton();
			_nextScene_Btn.x = 0;
			_nextScene_Btn.y = 0;
			_nextScene_Btn.addEventListener(MouseEvent.CLICK, onNextScene);
			addChild(_nextScene_Btn);			
			hideHud();
		}
		
		private function onNextScene(e:MouseEvent):void 
		{
			if (_hudActive) {
				dispatchEvent( new HudEvents(HudEvents.NEXT_SCENE_BUTTON_CLICKED) );
				hideHud();
			}
		}		
		
		public function hideHud():void 
		{
			_hudActive = false;
			_nextScene_Btn.alpha = 0;
		}
		
		public function showHud():void 
		{
			TweenMax.to( _nextScene_Btn, .3, { alpha:1, ease:Linear.easeNone, onComplete: hudReady } );
		}
		
		private function hudReady():void 
		{
			_hudActive = true;
		}
	}

}