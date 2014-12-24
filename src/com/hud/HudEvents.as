package com.hud 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class HudEvents extends Event 
	{
		static public const NEXT_SCENE_BUTTON_CLICKED:String = "nextSceneButtonClicked";
		
		public function HudEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new HudEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("HudEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}