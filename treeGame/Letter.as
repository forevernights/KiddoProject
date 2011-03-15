package treeGame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.Sound;
	
	import library.MyBitmapLoader;
	
	public class Letter extends Sprite
	{
		private var letter:String;
		private var pronounURL:String;
		private var pronoun:Sound;;
		public var order:Number;
		public var letterX:Number;
		public var letterY:Number;
		public var loader:MyBitmapLoader;
		private var gameWidth:Number;
		private var gameHeight:Number;
		public function Letter(whichWord:String,letterX:Number, letterY:Number, order:Number,gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.letter = whichWord;
			this.order=order;
			this.x=letterX;
			this.y=letterY;
			this.pronounURL="../letteraudio/"+this.letter+".mp3";
			this.loader = new MyBitmapLoader("../letterimages/"+this.letter+".png");
			this.loader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			this.addEventListener(Event.ENTER_FRAME, moveLetter);
			this.loadSound();
			
		}
		private function onLoaded(e:Event):void{
			loader.getLoader().height = gameHeight/12;
			loader.getLoader().width = gameWidth/12;
			addChild(loader.getLoader());
		}
		private function moveLetter(event:Event):void{
			loader.getLoader().y +=0.5;
			if(loader.getLoader().y==400){
				loader.getLoader().y=15;
				loader.getLoader().y+=0.5;
			}
			trace(loader.getLoader().y)
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(pronounURL);
			pronoun = new Sound();
			pronoun.load(url);	
		}
		public function playSound():void{
			pronoun.play();
		}
	}
}