package com.interfaceScreens.mainMenu 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class MainMenu extends MovieClip 
	{
		private var _clip:MainMenu_MC;
		private var _playButton:MovieClip;
		private var _optionsButton:MovieClip;
		
		public function MainMenu() 
		{
			_clip = new MainMenu_MC();
			addChild(_clip);
			
			init();
		}
		
		private function init():void 
		{
			_playButton = _clip.play_btn;
			_playButton.buttonMode = true;
			_playButton.mouseChildren = false;
			_playButton.addEventListener(MouseEvent.CLICK, onPlayButtonClicked);
			
			_optionsButton = _clip.options_btn;
			_optionsButton.buttonMode = true;
			_optionsButton.mouseChildren = false;	
			_optionsButton.addEventListener(MouseEvent.CLICK, onOptionsButtonClicked);
		}
		
		public function cleanUp():void 
		{
			
			_playButton.removeEventListener(MouseEvent.CLICK, onPlayButtonClicked);			
			_optionsButton.removeEventListener(MouseEvent.CLICK, onOptionsButtonClicked);
			removeChild( _clip );
			_clip = null;
		}
		
		private function onPlayButtonClicked(e:MouseEvent):void 
		{
			trace("onPlayButtonClicked");
			dispatchEvent( new MainMenuEvents(MainMenuEvents.PLAY_BUTTON_CLICKED) );
		}
		
		private function onOptionsButtonClicked(e:MouseEvent):void 
		{
			trace("onOptionsButtonClicked");
		}
		
	}

}