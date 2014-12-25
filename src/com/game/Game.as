package com.game 
{
	import com.game.SceneData;
	import com.greensock.easing.Back;
	import com.greensock.easing.Ease;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Game extends MovieClip 
	{
		private var _sceneData:SceneData;
		private var _currentSceneNum:int;
		private var _activeScene:Object;
		private var _activeSceneClip:MovieClip;
		private var _activeSceneData:Object;
		
		public function Game() {}
		
		public function init(e:Event = null):void 
		{
			_sceneData 			= new SceneData();
			_currentSceneNum 	= 0;	
			_activeScene 		= null;			
			initScene(_currentSceneNum);
		}
		
		public function onNextScene():void 
		{
			_currentSceneNum = _currentSceneNum < _sceneData.totalNumberOfScenes-1? _currentSceneNum + 1:0;
			trace("onNextScene " + _currentSceneNum);
			initScene(_currentSceneNum);
		}
		/**
		 * initalizes and displays the specified scene
		 * @param	sceneNum
		 */
		private function initScene(sceneNum:int):void 
		{
				var _previousScene:Object = _activeScene;
				_currentSceneNum = sceneNum;
				_activeScene =  _sceneData.getScene(_currentSceneNum);
				_activeScene.sceneClip.x = ( Main.SCREEN_WIDTH+(_activeScene.sceneClip.width/2) );
				//_activeScene.sceneClip.y = (stage.height / 2);
				_activeScene.sceneClip.scaleX = .80;
				_activeScene.sceneClip.scaleY = .80;				
				addChild( _activeScene.sceneClip );
				
				// --- init scene objects ---						
				var sceneData:Array = _activeScene.sceneData
				for (var i:int = 0; i < sceneData.length; i++) 
				{
					var sceneObject:Object = sceneData[i];					
					_activeScene.sceneClip[sceneObject.instanceName].buttonMode = true;
					MovieClip(_activeScene.sceneClip[sceneObject.instanceName]).mouseChildren = false;
					_activeScene.sceneClip[sceneObject.instanceName].addEventListener(MouseEvent.CLICK, handleObjectClicked);
				}
				
				// --- Transiition out previous scene ---							
					var tm:TimelineMax = new TimelineMax( { onComplete: sceneTransitionInDone } );
				if (_previousScene != null) {
					tm.insert( TweenMax.to( _previousScene.sceneClip, .5, { autoAlpha:1, scaleX:.80, scaleY:.80, ease:Back.easeOut } ) );
					tm.add( TweenMax.to(_previousScene.sceneClip, 1.0, {x: -(_previousScene.sceneClip.width+600), ease:Back.easeIn} ) );;	
				}
				
				// --- Transistion in scene ---
				tm.add( TweenMax.to( _activeScene.sceneClip, 1.0, {x: 0, ease:Back.easeOut} ) );
				tm.add( TweenMax.to( _activeScene.sceneClip,  .5, { autoAlpha:1, scaleX: 1, scaleY: 1, ease:Back.easeOut } ) );			
		}
		
		private function handleObjectClicked(e:MouseEvent):void 
		{
			trace("test " + e.target + " " + e.target.name);
			//find the object name						
			var sceneData:Array = _activeScene.sceneData
			for (var i:int = 0; i < sceneData.length; i++) 
			{
				var sceneObject:Object = sceneData[i];	
				if (sceneObject.instanceName == e.target.name) 
				{
					// play object animation
					e.target.gotoAndPlay("action");
					
					// run/fly off screen if needed
					if (sceneObject.runOffDirection) runOffScreen( MovieClip(e.target), sceneObject.runOffDirection );
					
					// play object soundFX
				}
			}
		}
		
		private function runOffScreen(clip:MovieClip, direction:String):void 
		{
			var startX:Number = clip.x;
			var destX:Number =  direction == SceneData.LEFT ? Main.OFF_SCREEN_LEFT - clip.width:Main.OFF_SCREEN_RIGHT;
			TweenMax.to( clip, 1.0, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreen, onCompleteParams:[clip, startX, direction] } );
		}
		
		private function comeBackOnScreen(clip:MovieClip, destX:Number, direction:String):void 
		{
			clip.gotoAndPlay("action");
			var startX:Number = direction == SceneData.LEFT ? Main.OFF_SCREEN_RIGHT:Main.OFF_SCREEN_LEFT - clip.width;
			clip.x = startX;
			TweenMax.to( clip, 1.0, { x: destX, ease:Linear.easeNone, onComplete: comeBackOnScreenDone, onCompleteParams: [clip] } );
		}
		
		private function comeBackOnScreenDone(clip:MovieClip):void 
		{
			clip.gotoAndStop("idle");
		}
		
		private function sceneTransitionInDone():void 
		{
			dispatchEvent( new GameEvents(GameEvents.SCENE_TRANSITION_IN_DONE) );			
		}
		
		
		
	}

}