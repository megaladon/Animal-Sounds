package com.soundManager 
{
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class SoundManager 
	{
		public const NORMAL:String = "1";
		
		public function SoundManager() 
		{
			
		}
		
		public function playSound(soundData:Object):SoundInstance 
		{
			SoundAS.loadSound(soundData.file, NORMAL);
			//SoundAS.getSound( NORMAL );
			var snd:SoundInstance = SoundAS.play(NORMAL, .2);
			//snd.soundCompleted.add(playPause);
			
			trace("playSound "+typeof(snd))
			return snd;
		}
		
		
		public function stopSound(snd:SoundInstance):void 
		{
			//SoundAS.removeSound(snd);
			//SoundAS.add
			snd.destroy();
		}
	}

}