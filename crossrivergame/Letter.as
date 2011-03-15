package crossrivergame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.Sound;
	
	import library.MyBitmapLoader;
	
	public class Letter extends Sprite
	{
		private var letter:String;
		private var letterX:Number;
		private var letterY:Number;
		private var order:Number;
		public var loader:MyBitmapLoader;
		private var loaderStar:MyBitmapLoader;
		private var pronounURL:String;
		private var pronoun:Sound;
		private var gameWidth:Number;
		private var gameHeight:Number;

		public function Letter(letter:String, letterX:Number,letterY:Number,order:Number,gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.letter=letter;
			this.x=letterX;
			this.y=letterY;
			this.order=order;
			this.pronounURL="../letteraudio/"+this.letter+".mp3";
			this.loaderStar = new MyBitmapLoader("../images/crossrivergame/star.gif");
			this.loaderStar.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedStar);
			this.loader = new MyBitmapLoader("../letterimages/"+this.letter+".png");
			this.loader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			this.addChild(loaderStar.getLoader());
			this.addChild(loader.getLoader());
			this.loadSound();
		}

		private function onLoaded(e:Event):void{
			loader.getLoader().height = gameHeight/15;
			loader.getLoader().width = gameWidth/15;
			if(order==4){
				loader.getLoader().x=gameWidth-loader.getLoader().width*10.2;
				loaderStar.getLoader().x =loader.getLoader().x-10 ;
				loaderStar.getLoader().y=loader.getLoader().y+3;
			}
			
		}
		private function onLoadedStar(event:Event):void{
			loaderStar.getLoader().width=gameWidth/10;
			loaderStar.getLoader().height=gameHeight/8.5;
			loaderStar.getLoader().x=loader.getLoader().x-15;
			loaderStar.getLoader().y=loader.getLoader().y-20;
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(pronounURL);
			pronoun = new Sound();
			pronoun.load(url);	
		}
		public function playSoundLetter():void{
			pronoun.play();
		}
	}
}