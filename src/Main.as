package 
{
	import com.game.Game;
	import com.game.GameEvents;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Sine;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.hud.Hud;
	import com.hud.HudEvents;
	import com.interfaceScreens.mainMenu.MainMenu;
	import com.interfaceScreens.mainMenu.MainMenuEvents;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	import flash.system.*
	
	/**
	 * ...
	 * @author Keith Goodman
	 */
	public class Main extends Sprite 
	{
		static public const SCREEN_WIDTH:int = 2048;
		static public const OFF_SCREEN_LEFT:Number = -(SCREEN_WIDTH / 2);
		static public const OFF_SCREEN_RIGHT:Number = SCREEN_WIDTH/2;
		
		private var _mainMenu:MainMenu;
		private var _game:Game;
		private var _mainLayer:MovieClip;
		
		// debug vars
		private var _debugLayer:MovieClip;
		private var _debugTextField:TextField;
		private var _hud:Hud;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// --- Init layers ---
			_mainLayer = new MovieClip();
			_debugLayer = new MovieClip();
			addChild(_mainLayer);
			addChild(_debugLayer);			
			
			// --- Init main menu ---
			initMainMenu();
			
			// --- Init debug loop ---
			_debugTextField = new TextField();
			// set the text format before setting the text property
			var myFormat:TextFormat = new TextFormat()
			myFormat.size  = 25 
			myFormat.color = "0xff0000"
			myFormat.bold  = true
			myFormat.font  = "Arial"
			_debugTextField.defaultTextFormat = myFormat	
			_debugTextField.x = 200;
			_debugTextField.y = 0;
			_debugTextField.width = 300
			_debugTextField.autoSize = TextFieldAutoSize.CENTER;
			_debugLayer.addChild(_debugTextField);
			
			var dropShadow:DropShadowFilter =  new DropShadowFilter();    
			_debugTextField.filters =  new Array(dropShadow);
			
			addEventListener(Event.ENTER_FRAME, debugLoop);
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
			_mainMenu.x = 1024;
			_mainMenu.y = 768;
			_mainMenu.addEventListener(MainMenuEvents.PLAY_BUTTON_CLICKED, handlePlayClicked);
			_mainLayer.addChild(_mainMenu);
		}
		
		private function handlePlayClicked(e:MainMenuEvents):void 
		{
			// Init gameScreen
			_game 	= new Game();
			_game.x = 1024;
			_game.y = 768;
			_game.addEventListener(GameEvents.SCENE_TRANSITION_IN_DONE, sceneReady);
			_mainLayer.addChild(_game);
			
			// Init hud
			_hud = new Hud();
			_hud.addEventListener(HudEvents.NEXT_SCENE_BUTTON_CLICKED, onNextScene);
			addChild(_hud);
			
			// Start mainMenu removal transition
			var tm:TimelineMax = new TimelineMax( {onComplete: mainMenuTransitionOutDone} );
			tm.insert( TweenMax.to( _mainMenu, .5, { autoAlpha:1, scaleX:.80, scaleY:.80, ease:Back.easeInOut } ) );
			tm.add( TweenMax.to(_mainMenu, 1.0, {x: -(_mainMenu.width-600), ease:Back.easeInOut} ) );
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
			_game.onNextScene();
		}
		
		private function mainMenuTransitionOutDone():void 
		{
			_mainMenu.cleanUp();
			_mainMenu.removeEventListener(MainMenuEvents.PLAY_BUTTON_CLICKED, handlePlayClicked);
			_mainLayer.removeChild(_mainMenu);
			_mainMenu = null;			
			_game.init();
		}		
		
	}
	
}