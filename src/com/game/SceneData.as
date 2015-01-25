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
				{instanceName: "rainCloud", title: "RAIN CLOUD", soundData: {file: "", loop: false, volume: 1} },
				{instanceName: "ram", title: "RAM", sfx: "" },
				{instanceName: "cow", title: "COW", sfx: "" },
				{instanceName: "horse", title: "HORSE", sfx: "" },
				{instanceName: "pig", title: "PIG", sfx: "" },
				{instanceName: "chicken", title: "CHICKEN", sfx: "", runOffDirection: LEFT, speed: 2 }
			];
			
			var scene1:Array = 
			[
				{instanceName: "blueBird", title: "BLUE BIRD", sfx: "", idleWalk: {speed: 20, dir: RIGHT} },
				{instanceName: "bear", title: "BEAR", sfx: "" },
				{instanceName: "turtle", title: "TURTLE", sfx: "" },
				{instanceName: "turtle2", title: "TURTLE2", sfx: "", idleWalk: {speed: 20, dir: LEFT } },
				{instanceName: "dog", title: "DOG", sfx: "", runOffDirection: LEFT, speed: 1 },
				{instanceName: "eagle", title: "EAGLE", sfx: "", idleWalk: {speed: 20, dir: LEFT } }
			];
			
			var scene2:Array = 
			[
				{instanceName: "wolf", title: "WOLF", sfx: "" },
				{instanceName: "tiger", title: "TIGER", sfx: "" },		
				{instanceName: "dragon", title: "DRAGON", sfx: "" },		
				{instanceName: "rat", title: "RAT", sfx: "", idleOdds: 2, runOffDirection: LEFT, speed: 2 },		
				{instanceName: "rat2", title: "RAT", sfx: "", idleOdds: 2, runOffDirection: RIGHT, speed: 2 }
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