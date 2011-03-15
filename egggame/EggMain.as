package egggame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import library.MyBitmapLoader;
	
	public class EggMain extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var backgroundLoader:MyBitmapLoader;
		private var chickLoader:MyBitmapLoader;
		
		public function EggMain(gameWidth:Number,gameHeight:Number):void{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.backgroundLoader = new MyBitmapLoader("../images/egggame/hay_background.jpg");
			this.backgroundLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onBackgroundLoaded);
			this.chickLoader = new MyBitmapLoader("../images/egggame/chick.png");
			this.chickLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onChickLoaded);
			addChild(backgroundLoader.getLoader());
			addChild(chickLoader.getLoader());
			addChild(new EggBoard(gameWidth,gameHeight));
		}
		private function onBackgroundLoaded(event:Event):void{
			this.backgroundLoader.getLoader().width = gameWidth;
			this.backgroundLoader.getLoader().height = gameHeight;
			this.backgroundLoader.getLoader().x = 0;
			this.backgroundLoader.getLoader().y = 0;
		}
		private function onChickLoaded(event:Event):void{
			this.chickLoader.getLoader().width = gameWidth/8;
			this.chickLoader.getLoader().height = gameHeight/5;
			this.chickLoader.getLoader().x = gameWidth - this.chickLoader.getLoader().width*6.7;
			this.chickLoader.getLoader().y = gameHeight - this.chickLoader.getLoader().height*2.6;
		}
	}
}