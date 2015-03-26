package 
{
	import com.game.Game;
	import com.game.GameEvents;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.hud.Hud;
	import com.hud.HudEvents;
	import com.interfaceScreens.mainMenu.MainMenu;
	import com.interfaceScreens.mainMenu.MainMenuEvents;
	import com.intro.Intro;
	import com.intro.IntroEvents;
	import com.transitions.TransitionEvents;
	import com.transitions.TransitionManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import treefortress.sound.SoundAS;
	
	
	import flash.system.*
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Main extends Sprite 
	{
		static public const SCREEN_WIDTH:int = 1024;
		static public const OFF_SCREEN_LEFT:Number = 0
		static public const OFF_SCREEN_RIGHT:Number = SCREEN_WIDTH
		
		private var _mainMenu:MainMenu;
		private var _game:Game;
		private var _mainLayer:MovieClip;
		private var _introLayer:MovieClip;
		
		// debug vars
		private var _debugLayer:MovieClip;
		private var _debugTextField:TextField;
		private var _hud:Hud;
		private var _intro:Intro;
		private var _tm:TransitionManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// --- Init layers ---
			_mainLayer 	= new MovieClip();
			_introLayer	= new MovieClip();
			_debugLayer = new MovieClip();
			
			addChild(_mainLayer);
			addChild(_introLayer);
			addChild(_debugLayer);			
			
			// --- Init Intro -- 
			_intro = new Intro();
			_introLayer.addChild(_intro);
			_intro.addEventListener(IntroEvents.INTRO_DONE, introDone);
			
			// --- Init main menu ---
			initMainMenu();
			
			// --- Init debug loop ---
			//_debugTextField = new TextField();
			//// set the text format before setting the text property
			//var myFormat:TextFormat = new TextFormat()
			//myFormat.size  = 25 
			//myFormat.color = "0xff0000"
			//myFormat.bold  = true
			//myFormat.font  = "Arial"
			//_debugTextField.defaultTextFormat = myFormat	
			//_debugTextField.x = 200;
			//_debugTextField.y = 0;
			//_debugTextField.width = 300
			//_debugTextField.autoSize = TextFieldAutoSize.CENTER;
			//_debugLayer.addChild(_debugTextField);
			//
			//var dropShadow:DropShadowFilter =  new DropShadowFilter();    
			//_debugTextField.filters =  new Array(dropShadow);
			//
			//addEventListener(Event.ENTER_FRAME, debugLoop);
		}
		
		private function introDone(e:IntroEvents):void 
		{
			TweenMax.to( _intro, 1, { alpha: 0, delay: 1, ease:Linear.easeNone, onComplete: removeIntro } );
		}
		
		private function removeIntro():void 
		{			
			_introLayer.removeChild(_intro);
		}
		
		private function debugLoop(e:Event):void 
		{
			var kb:Number = System.totalMemory / 1024;
			var mb:Number = kb / 1024;
			var txt:String = "kb: " + Math.round(kb) + " mb: " + Math.round(mb);
			_debugTextField.text = txt;
		}
		
		private function initMainMenu():void 
		{
			_mainMenu 	= new MainMenu();
			_mainMenu.addEventListener(MainMenuEvents.PLAY_BUTTON_CLICKED, handlePlayClicked);
			_mainLayer.addChild(_mainMenu);
		}
		
		private function handlePlayClicked(e:MainMenuEvents):void 
		{
			// Init gameScreen
			_game 	= new Game();
			//_game.x = 1024;
			//_game.y = 768;
			_game.addEventListener(GameEvents.SCENE_TRANSITION_IN_DONE, sceneReady);
			_mainLayer.addChild(_game);
			
			// Create a mask for the level
			var sceneMask:MovieClip = new MovieClip();
            sceneMask.graphics.beginFill(0xFFCC00);
            sceneMask.graphics.drawRect(0, 0, 2048, 1536);
            sceneMask.graphics.endFill();
            addChild(sceneMask);
			_game.mask = sceneMask;	
			
			// Init hud
			_hud = new Hud();
			_hud.addEventListener(HudEvents.NEXT_SCENE_BUTTON_CLICKED, onNextScene);
			addChild(_hud);
			
			mainMenuTransitionOutDone();
			// Start mainMenu removal transition
			//var tm:TimelineMax = new TimelineMax( {onComplete: mainMenuTransitionOutDone} );
			//tm.insert( TweenMax.to( _mainMenu, .5, { autoAlpha:1, scaleX:.80, scaleY:.80, ease:Back.easeInOut } ) );
			//tm.add( TweenMax.to(_mainMenu, 1.0, {x: -(_mainMenu.width-600), ease:Back.easeInOut} ) );
		}
		/**
		 * Called when the current scene is done transitioning in.
		 * @param	e
		 */
		private function sceneReady(e:GameEvents):void 
		{
			_hud.showHud();
		}
		
		private function onNextScene(e:HudEvents):void 
		{
			SoundAS.stopAll();
			_game.onNextScene();
			
			_tm = new TransitionManager(TransitionEvents.TRANSITION_OUT, TransitionEvents.DOORS);
			_tm.addEventListener(TransitionEvents.TRANSITION_OUT_DONE, initNextScene);
			addChild(_tm);
		}
		
		private function initNextScene(e:TransitionEvents):void 
		{
			_game.initNextScene();
			_tm.doorTransitionIn();
			_tm.addEventListener(TransitionEvents.TRANSITION_IN_DONE, transitionInDone);
		}
		
		private function transitionInDone(e:TransitionEvents):void 
		{
			removeChild(_tm);
		}
		
		private function mainMenuTransitionOutDone():void 
		{
			_mainMenu.cleanUp();
			_mainMenu.removeEventListener(MainMenuEvents.PLAY_BUTTON_CLICKED, handlePlayClicked);
			_mainLayer.removeChild(_mainMenu);
			_mainMenu = null;			
			_game.init();
		}
		
		public static function hiliteClip(clip:MovieClip):void {
			
			var glowFilter:GlowFilter = new GlowFilter();
			glowFilter.color = 0xffffff;
			glowFilter.alpha = 1;
			glowFilter.blurX = 15;
			glowFilter.blurY = 15;
			clip.filters = [glowFilter];
				trace("hiliteClip");
			
		}
		
		public static function unHiliteClip(clip:MovieClip):void {
			clip.filters = [];
		}
		
	}
	
}