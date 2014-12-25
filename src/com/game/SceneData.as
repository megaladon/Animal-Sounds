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
			var sceneClip:Scene0 = new Scene0();			
			var scene0:Array = 
			[
				{instanceName: "balloons", title: "BALLOONS", sfx: "" },
				{instanceName: "rainCloud", title: "RAIN CLOUD", sfx: "" },
				{instanceName: "ram", title: "RAM", sfx: "", runOffDirection: LEFT },
				{instanceName: "dog", title: "DOG", sfx: "", runOffDirection: LEFT },
				{instanceName: "birds", title: "BIRDS", sfx: "" }
			];
			
			var scene1:Array = 
			[
				{instanceName: "alien", title: "Alien", sfx: "" }
			];
			_scenes = [scene0, scene1];		
			
			_totalNumberOfScenes = _scenes.length;
		}
		
		public function getScene(sceneNum:int):Object 
		{
			var sceneClips:Array = [new Scene0(), new Scene1()];
			var scene:Object = { sceneClip: sceneClips[sceneNum], sceneData: _scenes[sceneNum] };
			return scene;			
		}
		
		public function get totalNumberOfScenes():int 
		{
			return _totalNumberOfScenes;
		}
				
	}

}