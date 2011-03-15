package treeGame
{
	import flash.display.*;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import library.MyBitmapLoader;
	
	public class Basket extends Sprite
	{	
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var loaderBasket:MyBitmapLoader;
		public function Basket(gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.loaderBasket = new MyBitmapLoader("../images/treegame/basket.gif");
			this.loaderBasket.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedBasket);
		}
		
		public function onLoadedBasket(e:Event):void{
			loaderBasket.getLoader().height=gameHeight/6;
			loaderBasket.getLoader().width=gameWidth/6;
			loaderBasket.getLoader().x=-loaderBasket.getLoader().width/2;
			loaderBasket.getLoader().y=-loaderBasket.getLoader().height/2;
			addChild(loaderBasket.getLoader());
		}		
	}
}