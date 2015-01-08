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
				{instanceName: "rainCloud", title: "RAIN CLOUD", sfx: "" },
				{instanceName: "ram", title: "RAM", sfx: "" },
				{instanceName: "cow", title: "COW", sfx: "" },
				{instanceName: "horse", title: "HORSE", sfx: "" },
				{instanceName: "pig", title: "PIG", sfx: "" },
				{instanceName: "chicken", title: "CHICKEN", sfx: "", runOffDirection: LEFT, speed: 2 }
			];
			
			var scene1:Array = 
			[
				{instanceName: "blueBird", title: "BLUE BIRD", sfx: "", idleWalk: {speed: 20 } },
				{instanceName: "bear", title: "BEAR", sfx: "" },
				{instanceName: "turtle", title: "TURTLE", sfx: "" },
				{instanceName: "turtle2", title: "TURTLE2", sfx: "", idleWalk: {speed: 20 } },
				{instanceName: "dog", title: "DOG", sfx: "", runOffDirection: LEFT, speed: 1 },
				{instanceName: "eagle", title: "EAGLE", sfx: "", idleWalk: {speed: 20 } }
			];
			
			var scene2:Array = 
			[			
				{instanceName: "rat", title: "RAT", sfx: "", runOffDirection: LEFT, speed: 2 }
			];
			
			_scenes = [scene0, scene1, scene2];		
			
			_totalNumberOfScenes = _scenes.length;
		}
		
		public function getScene(sceneNum:int):Object 
		{
			var sceneClips:Array = [new Scene0(), new Scene1(), new Scene2];
			var scene:Object = { sceneClip: sceneClips[sceneNum], sceneData: _scenes[sceneNum] };
			return scene;			
		}
		
		public function get totalNumberOfScenes():int 
		{
			return _totalNumberOfScenes;
		}
				
	}

}