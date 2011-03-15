package treeGame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	
	import library.MyBitmapLoader;
	
	public class treeGame extends Sprite
	{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var loaderSpeaker:MyBitmapLoader;
		private var words:Array = ["blab","clad","flip"];
		private var basket:Basket = new Basket(gameWidth,gameHeight);
		public function treeGame(gameWidth:Number,gameHeight:Number)
		{
			
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.loadTheTree();	
			this.loaderSpeaker = new MyBitmapLoader("../images/treegame/speaker.gif");
			this.loaderSpeaker.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSpeaker);			
			this.loaderSpeaker.getLoader().addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.loaderSpeaker.getLoader().addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			this.loaderSpeaker.getLoader().addEventListener(MouseEvent.CLICK,onSpeaker);
			this.moveBasket();
		}
		private var numArray:Array = [0,1,2];
		private var largest:Number = 2;
		private function pickRandomWord():Number{
			var random:Number = Math.floor(Math.random()*(1+largest-0))+0;
			var returnNum:Number = numArray[random];
			numArray.splice(random,1);
			largest--;
			return returnNum;
		}
		public function moveBasket(): void {
			basket.startDrag(true);
			Mouse.hide();
			this.addChild(basket);
		}
		public function loadTheTree():void{
			var tree: Tree = new Tree(gameWidth,gameHeight);
			this.addChild(tree);
		}
		private function onLoadedSpeaker(e:Event):void{
			loaderSpeaker.getLoader().x = 0;
			loaderSpeaker.getLoader().y = gameHeight - loaderSpeaker.getLoader().height/1.2;
			loaderSpeaker.getLoader().height = gameWidth/8;
			loaderSpeaker.getLoader().width = gameWidth/8;
			addChild(loaderSpeaker.getLoader());
		}
		private function onMouseOver(event:Event):void{
			Mouse.show();
			basket.visible=false;
		}
		private function onMouseOut(event:Event):void{
			Mouse.hide();
			basket.visible=true;
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
	}
}
