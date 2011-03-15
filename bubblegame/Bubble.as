package bubblegame {
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import library.MyBitmapLoader;
	
	public class Bubble extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var wordSound:Sound;
		private var bellSound:Sound;
		private var praiseSound:Sound;
		private var buzzSound:Sound;
		private var stringURL:String;
		private var soundURL:String;
		private var bellSoundURL:String;
		private var praiseSoundURL:String;
		private var buzzSoundURL:String;
		private var locationX:Number;
		private var locationY:Number;
		private var speedX:Number;
		private var speedY:Number;
		public var word:String;
		private var loader:MyBitmapLoader;
		private var secLoader:MyBitmapLoader;		
		
		public function Bubble(locationX:Number,locationY:Number,speedX:Number,speedY:Number,whichWord:String,gameWidth:Number,gameHeight:Number):void{
			this.word = whichWord;
			this.x = locationX;
			this.y = locationY;
			this.speedX = speedX;
			this.speedY = speedY;
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.loader = new MyBitmapLoader("../images/bubblegame/bubble_pink.gif");
			this.secLoader = new MyBitmapLoader("../content/voice1/cvc/"+whichWord+"/flashcard/cover_bw_200x100.png");	
			this.soundURL = "../content/voice1/cvc/"+whichWord+"/audio/"+whichWord+".mp3";
			this.bellSoundURL = "../sound/bell.mp3";
			this.praiseSoundURL = "../sound/wellDone.mp3";
			this.buzzSoundURL = "../sound/bounce.mp3";
			this.loader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedBubble);
			this.secLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedWord);	
			this.loader.getLoader().addEventListener(Event.ENTER_FRAME, animateBubble);
			addChild(loader.getLoader());
			addChild(secLoader.getLoader());

			loadSound();
			loadBellSound();
			loadPraiseSound();
			loadBuzzSound();
		}
		private function onLoadedBubble(e:Event):void{
			this.loader.getLoader().width = 150;
			this.loader.getLoader().height = 150;
		}
		private function onLoadedWord(e:Event):void{
			this.secLoader.getLoader().x = this.loader.getLoader().x - 20;
			this.secLoader.getLoader().y = this.loader.getLoader().y + 25;
		}
		private function animateBubble(event:Event):void{
			this.x+=speedX;
			this.y+=speedY;
			
			if(this.x > 850 || this.x < 0){
				speedX = -speedX;
			}
			if(this.y > 595 || this.y < 0){
				speedY = -speedY;
			}
		} 
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundURL);
			wordSound = new Sound();
			wordSound.load(url);	
		}
		public function playSound():void{
			wordSound.play();
		}
		private function loadBellSound():void{
			var url:URLRequest = new URLRequest(bellSoundURL);
			bellSound = new Sound();
			bellSound.load(url);
		}
		public function playBellSound():void{
			bellSound.play();
		}
		private function loadPraiseSound():void{
			var url:URLRequest = new URLRequest(praiseSoundURL);
			praiseSound = new Sound();
			praiseSound.load(url);
		}
		public function playPraiseSound():void{
			praiseSound.play();
		}
		private function loadBuzzSound():void{
			var url:URLRequest = new URLRequest(buzzSoundURL);
			buzzSound = new Sound();
			buzzSound.load(url);
		}
		public function playBuzzSound():void{
			buzzSound.play();
		}
		
		public function isAllLoaded():Boolean{
			if(loader.isLoaded&&secLoader.isLoaded){
				return true;
			}
			else{
				return false;
			}
		}
	}
}
