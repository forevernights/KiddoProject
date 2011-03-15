package egggame
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import library.MyBitmapLoader;
	
	public class Letter extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var vowelSoundURL:String;
		private var vowelSound:Sound;
		public var letter:String;
		public var order:Number;
		private var locationX:Number;
		private var locationY:Number;
		public var letterLoader:MyBitmapLoader;
		private var eggLoader:MyBitmapLoader
		
		public function Letter(letter:String,locationX:Number,locationY:Number,order:Number,gameWidth:Number,gameHeight:Number){
			this.letter = letter;
			this.order = order;
			this.x = locationX;
			this.y = locationY;
			this.letterLoader = new MyBitmapLoader("../letterimages/"+letter+".png");
			this.eggLoader = new MyBitmapLoader("../images/egggame/egg.png");
			this.vowelSoundURL = "../letteraudio/"+letter+".mp3";
			this.letterLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedLetter);
			this.eggLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedEgg);
			addChild(letterLoader.getLoader());
			addChild(eggLoader.getLoader());
			
			loadVowelSound();
		}
		private function loadVowelSound():void{
			var url:URLRequest = new URLRequest(vowelSoundURL);
			vowelSound = new Sound();
			vowelSound.load(url);
		}
		public function playVowelSound():void{
			vowelSound.play();
		}
		private function onLoadedLetter(e:Event):void{
			letterLoader.getLoader().width = 70;
			letterLoader.getLoader().height = 80;
			addChild(letterLoader.getLoader());
			if(order==1){
				letterLoader.getLoader().visible=false;
				eggLoader.getLoader().visible=false;
			}  
		}
		private function onLoadedEgg(e:Event):void{
			eggLoader.getLoader().width = 80;
			eggLoader.getLoader().height = 100;
			eggLoader.getLoader().x = letterLoader.getLoader().x-10;
			eggLoader.getLoader().y = letterLoader.getLoader().y-10;
		}
	}
}