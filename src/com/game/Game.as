package com.game 
{
	import com.game.animal.Animal;
	import com.game.SceneData;
	import com.greensock.easing.Back;
	import com.greensock.easing.Ease;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.transitions.TransitionEvents;
	import com.transitions.TransitionManager;
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
		private var _walkTM:TimelineMax;
		private var _tm:TransitionManager;
		
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
			_currentSceneNum = _currentSceneNum < _sceneData.totalNumberOfScenes - 1? _currentSceneNum + 1:0;
			//
		}
		/**
		 * Called when transition out is done
		 * @param	e
		 */
		public function initNextScene():void 
		{
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
				_activeScene.sceneClip.x = 0//( Main.SCREEN_WIDTH+(_activeScene.sceneClip.width/2) );
				//_activeScene.sceneClip.y = (stage.height / 2);
				//_activeScene.sceneClip.scaleX = .80;
				//_activeScene.sceneClip.scaleY = .80;				
				addChild( _activeScene.sceneClip );
				
				// --- init scene objects ---
				var _animals:Array = [];
				var sceneData:Array = _activeScene.sceneData;
				for (var i:int = 0; i < sceneData.length; i++) 
				{
					var sceneObject:Object = sceneData[i];
					var animal:Animal = new Animal(MovieClip(_activeScene.sceneClip[sceneObject.instanceName]), sceneData[i] );	
					_animals.push( animal );
				}
				
				// --- Transition out previous scene ---							
					var tm:TimelineMax = new TimelineMax( { onComplete: sceneTransitionInDone } );
				if (_previousScene != null) {
					sceneTransitionInDone();
					removeChild( _previousScene.sceneClip );
					_previousScene = null;
					//tm.insert( TweenMax.to( _previousScene.sceneClip, .5, { autoAlpha:1, scaleX:.80, scaleY:.80, ease:Back.easeOut } ) );
					//tm.add( TweenMax.to(_previousScene.sceneClip, 1.0, {x: -(_previousScene.sceneClip.width+600), ease:Back.easeIn} ) );;	
				}
				
				// --- Transition in scene ---
				_activeScene.sceneClip.x = 0;
				
				transitionIn();
				//tm.add( TweenMax.to( _activeScene.sceneClip, 1.0, {x: 0, ease:Back.easeOut} ) );
				//tm.add( TweenMax.to( _activeScene.sceneClip,  .5, { autoAlpha:1, scaleX: 1, scaleY: 1, ease:Back.easeOut } ) );			
		}
		
		private function transitionIn():void 
		{
			sceneTransitionInDone();
		}
		
		private function sceneTransitionInDone():void 
		{
			dispatchEvent( new GameEvents(GameEvents.SCENE_TRANSITION_IN_DONE) );			
		}		
		
		
	}

}