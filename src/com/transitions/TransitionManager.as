package com.transitions 
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class TransitionManager extends MovieClip 
	{
		private var _doors:Doors;
		
		public function TransitionManager(direction:String, type:String) 
		{
			switch (type) 
			{
				case TransitionEvents.DOORS:
					doDoorTransition(direction);
				break;
				default:
			}
		}
		
		private function doDoorTransition(direction:String):void 
		{
			if (direction == TransitionEvents.TRANSITION_OUT) 
			{
				doorTransitionOut();
			}else 
			{
				
			}
		}
		
		private function doorTransitionOut():void 
		{
			_doors = new Doors();
			_doors.leftDoor.x = -512;
			_doors.rightDoor.x = 1024;
			addChild(_doors);
			var leftDoorX:Number = 0;
			var rightDoorX:Number = 512;
			TweenMax.to( _doors.leftDoor, 1, { x: leftDoorX, ease:Linear.easeNone, onComplete: transitionOutDone } );
			TweenMax.to( _doors.rightDoor, 1, { x: rightDoorX, ease:Linear.easeNone } );
		}
		
		public function doorTransitionIn():void 
		{			
			var leftDoorX:Number = -512;
			var rightDoorX:Number = 1024;
			TweenMax.to( _doors.leftDoor, 1, { delay: .5, x: leftDoorX, ease:Linear.easeNone, onComplete: transitionInDone } );
			TweenMax.to( _doors.rightDoor, 1, { delay: .5, x: rightDoorX, ease:Linear.easeNone } );
		}
		
		private function transitionInDone():void 
		{
			dispatchEvent( new TransitionEvents(TransitionEvents.TRANSITION_IN_DONE) ); 
		}
		
		private function transitionOutDone():void 
		{
			dispatchEvent( new TransitionEvents(TransitionEvents.TRANSITION_OUT_DONE) )
		}
		
	}

}