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
		private var _animals:Array;
		
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
				_activeScene.sceneClip.x = 0			
				addChild( _activeScene.sceneClip );
				
				// --- init scene objects ---
				_animals = [];
				var sceneData:Array = _activeScene.sceneData;
				for (var i:int = 0; i < sceneData.length; i++) 
				{
					var sceneObject:Object = sceneData[i];
					var animal:Animal = new Animal(MovieClip(_activeScene.sceneClip[sceneObject.instanceName]), sceneData[i] );	
					animal.addEventListener(GameEvents.ANIMAL_CLICKED, checkAllAnimalsClicked);
					_animals.push( animal );
				}
				
				// --- Transition out previous scene ---							
					var tm:TimelineMax = new TimelineMax( { onComplete: sceneTransitionInDone } );
				if (_previousScene != null) {
					sceneTransitionInDone();
					removeChild( _previousScene.sceneClip );
					_previousScene = null;
				}
				
				// --- Transition in scene ---				
				transitionIn();			
		}
		
		private function checkAllAnimalsClicked(e:GameEvents):void 
		{
			var clicked:int = 0;
			for (var i:int = 0; i < _animals.length; i++) 
			{
				if (Animal(_animals[i]).hasBeenClicked ) clicked++;
			}
			trace("checkAllAnimalsClicked "+clicked);
			if (clicked == _animals.length) dispatchEvent( new GameEvents(GameEvents.ALL_ANIMALS_CLICKED) );
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