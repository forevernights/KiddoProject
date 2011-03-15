
package bubblegame
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import library.MyBitmapLoader;
	
	public class BubbleMain extends Sprite{
		
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var skyLoader:MyBitmapLoader;
		
		public function BubbleMain(gameWidth:Number,gameHeight:Number):void{
			
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.skyLoader = new MyBitmapLoader("../images/bubblegame/sky.jpg");
			this.skyLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSky);
			addChild(skyLoader.getLoader());
			addChild(new BubbleBoard(gameWidth,gameHeight));
		}
		private function onLoadedSky(event:Event):void{
			this.skyLoader.getLoader().width = gameWidth;
			this.skyLoader.getLoader().height = gameHeight;
			this.skyLoader.getLoader().x = 0;
			this.skyLoader.getLoader().y = 0;
		}
	}
}