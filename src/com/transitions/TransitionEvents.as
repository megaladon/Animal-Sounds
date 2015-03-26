package com.transitions 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class TransitionEvents extends Event 
	{
		public static const TRANSITION_IN:String 		= "transitionIn";
		public static const TRANSITION_OUT:String 		= "transitionOut";
		public static const DOORS:String				= "doors";
		public static const TRANSITION_OUT_DONE:String 	= "transitionOutDone";
		public static const TRANSITION_IN_DONE:String 	= "transitionInDone";
		
		public function TransitionEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TransitionEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TransitionEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}