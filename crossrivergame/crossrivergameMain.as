package crossrivergame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	import library.MyBitmapLoader;

	public class crossrivergameMain extends Sprite
	{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var loaderSpeaker:MyBitmapLoader;
		private var words:Array=["cleft","frisk","trend","spent"];
		public function crossrivergameMain(gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.loadBackground();
			this.loaderSpeaker = new MyBitmapLoader("../images/treegame/speaker.gif");
			this.loaderSpeaker.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSpeaker);
			this.loaderSpeaker.getLoader().addEventListener(MouseEvent.CLICK,onSpeaker);
		}
		private var numArray:Array = [0,1,2,3];
		private var largest:Number = 3;
		private function pickRandomWord():Number{
			var random:Number = Math.floor(Math.random()*(1+largest-0))+0;
			var returnNum:Number = numArray[random];
			numArray.splice(random,1);
			largest--;
			return returnNum;
		}
		private function onLoadedSpeaker(e:Event):void{
			loaderSpeaker.getLoader().x = 0;
			loaderSpeaker.getLoader().y = gameHeight - loaderSpeaker.getLoader().height/1.5;
			loaderSpeaker.getLoader().height = 150;
			loaderSpeaker.getLoader().width = 150;
			addChild(loaderSpeaker.getLoader());
		}
		private var doOne:Number = 0;
		public var word:Word;
		private function onSpeaker(event:MouseEvent): void{
			for(var j:Number=0; j<1;j++){
				if(doOne==0){
					word = new Word(words[this.pickRandomWord()],0,0,gameWidth,gameHeight);
					this.addChild(word);	
					doOne++;
				}
				word.playSound();
			}
		}
		private function loadBackground():void{
			var bg:Background = new Background(gameWidth,gameHeight);
			addChild(bg);
		}
	}
}