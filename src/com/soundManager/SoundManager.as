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
		
		private var _animalSounds:Array;
		
		public function SoundManager() 
		{
			_animalSounds = [];			
		}
		
		public function playSound(soundData:Object):SoundInstance 
		{
			SoundAS.loadSound(soundData.file, NORMAL);
			var snd:SoundInstance = SoundAS.play(NORMAL, soundData.volume, 0, soundData.loops);
			snd.soundCompleted.add(removeSoundFromArray);
			_animalSounds.push(snd);
			
			trace("playSound "+typeof(snd)+" "+soundData.file)
			return snd;
		}
		
		private function removeSoundFromArray(snd:SoundInstance):void 
		{
			for (var i:int = 0; i < _animalSounds.length; i++) 
			{
				if (_animalSounds[i] == snd) 
				{
					_animalSounds.splice(i, 1);
					break;
				}
			}
		}		
		
		public function stopSound(snd:SoundInstance):void 
		{
			removeSoundFromArray(snd);
			snd.destroy();
		}
		
		public function stopAllAnimalSounds():void 
		{			
			for (var i:int = 0; i < _animalSounds.length; i++) 
			{
				stopSound( _animalSounds[i] );
			}
		}
	}

}