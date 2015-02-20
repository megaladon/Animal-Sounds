package com.game {
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class SceneData 
	{
		static public const LEFT:String = "left";
		static public const RIGHT:String = "right";
		
		private var _scenes:Array;
		private var _totalNumberOfScenes:int;
		
		public function SceneData() 
		{
			//var sceneClip:Scene0 = new Scene0();			
			var scene0:Array = 
			[
				{instanceName: "rainCloud", title: "RAIN CLOUD", 	soundData: {file: "", loop: false, volume: 1} },
				{instanceName: "ram", 		title: "RAM", 			soundData: {file: "sounds/goat.mp3", 		loops: 0, volume: 1} },
				{instanceName: "cow", 		title: "COW", 			soundData: {file: "sounds/cow-moo-3.mp3", 	loops: 0, volume: 1} },
				{instanceName: "horse", 	title: "HORSE", 		soundData: {file: "sounds/horse.mp3", 		loops: 0, volume: 1} },
				{instanceName: "pig", 		title: "PIG", 			soundData: {file: "sounds/pig-grunt.mp3", 	loops: 0, volume: 1} },
				{instanceName: "chicken", 	title: "CHICKEN", 		soundData: {file: "sounds/clucking-01.mp3", loops: 0, volume: 1}, runOffDirection: LEFT, speed: 2 }
			];
			
			var scene1:Array = 
			[
				{instanceName: "blueBird", 	title: "BLUE BIRD", 	soundData: {file: "sounds/flapping-sound.mp3", loops: 0, volume: 1}, idleWalk: {speed: 20, dir: RIGHT} },
				{instanceName: "bear", 		title: "BEAR", 			soundData: {file: "sounds/growl.mp3", loops: 0, volume: 1} },
				{instanceName: "turtle", 	title: "TURTLE", 		soundData: {file: "sounds/turtle.mp3", loops: 0, volume: 1} },
				{instanceName: "turtle2", 	title: "TURTLE2", 		soundData: {file: "sounds/turtle.mp3", loops: 0, volume: 1}, idleWalk: {speed: 20, dir: LEFT } },
				{instanceName: "dog", 		title: "DOG", 			soundData: {file: "sounds/dog-double-bark.mp3", loops: 0, volume: 1}, runOffDirection: LEFT, speed: 1 },
				{instanceName: "eagle", 	title: "EAGLE", 		soundData: {file: "sounds/eagle-cry.mp3", loop: 0, volume: 1}, idleWalk: {speed: 20, dir: LEFT } }
			];
			
			var scene2:Array = 
			[
				{instanceName: "wolf", 		title: "WOLF", 		soundData: {file: "sounds/squeal.mp3", loops: 0, volume: 1}  },
				{instanceName: "tiger", 	title: "TIGER", 	soundData: {file: "", loops: 0, volume: 1}  },		
				{instanceName: "dragon",	title: "DRAGON", 	soundData: {file: "", loops: 0, volume: 1}  },		
				{instanceName: "rat", 		title: "RAT", 		soundData: {file: "sounds/mouse.mp3", loops: 0, volume: 1} , idleOdds: 2, runOffDirection: LEFT, speed: 2 },		
				{instanceName: "rat2", 		title: "RAT", 		soundData: {file: "sounds/mouse.mp3", loops: 0, volume: 1} , idleOdds: 2, runOffDirection: RIGHT, speed: 2 }
			];
			
			var scene3:Array = 
			[
				{instanceName: "terodactyl", title: "terodactyl", sfx: "", idleWalk: {speed: 20, dir: LEFT}  },
				{instanceName: "tRex", title: "T-REX", sfx: "" },
				{instanceName: "raptor", title: "RAPTOR", sfx: "", idleOdds: 2, runOffDirection: RIGHT, speed: 2 }			
			];
			
			var scene4:Array =
			[
				{instanceName: "ram2", title: "RAM", sfx: "" },
				{instanceName: "tractor", title: "TRACTOR", sfx: "", idleOdds: 2, runOffDirection: LEFT, speed: 4 }			
			];
			_scenes = [scene0, scene1, scene2, scene3, scene4];		
			
			_totalNumberOfScenes = _scenes.length;
		}
		
		public function getScene(sceneNum:int):Object 
		{
			var sceneClips:Array = [new Scene0(), new Scene1(), new Scene2(), new Scene3(), new Scene4()];
			var scene:Object = { sceneClip: sceneClips[sceneNum], sceneData: _scenes[sceneNum] };
			return scene;			
		}
		
		public function get totalNumberOfScenes():int 
		{
			return _totalNumberOfScenes;
		}
				
	}

}