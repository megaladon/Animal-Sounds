package com.game 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class GameEvents extends Event 
	{
		public static const SCENE_TRANSITION_IN_DONE:String = "sceneTransitionInDone";
		public static const ANIMAL_CLICKED:String = "animalClicked";
		public static const ALL_ANIMALS_CLICKED:String = "allAnimalsClicked";
		
		public function GameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}