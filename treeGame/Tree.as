package treeGame
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	
	import org.osmf.net.StreamingURLResource;

	public class Tree extends Sprite
	{
		private var loaderTree:MyBitmapLoader;
		private var loaderSky:MyBitmapLoader;
		public var autumnRiver:Sound;
		private var soundurl:String;
		private var gameWidth:Number;
		private var gameHeight:Number;

		public function Tree(gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.loaderTree = new MyBitmapLoader("../images/treegame/greentree.gif");
			this.loaderTree.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedTree);
			this.loaderSky = new MyBitmapLoader("../images/treegame/sky.jpg");
			this.loaderSky.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSky);
			this.soundurl="../sound/autumnriver.mp3";
			loadSound();
			playSound();
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundurl);
			autumnRiver = new Sound();
			autumnRiver .load(url);	
		}
		
		//play sound of the word 
		public function playSound():void{
			autumnRiver.play();
		}
		
		private function onLoadedSky(event:Event):void{
			//this.loaderSky.getLoader().width=gameWidth;
			//this.loaderSky.getLoader().height=gameHeight;
			this.loaderSky.getLoader().x=0;
			this.loaderSky.getLoader().y=0;
			addChild(loaderSky.getLoader());
		}
		private function onLoadedTree(event:Event):void{
			this.loaderTree.getLoader().y=gameHeight-loaderTree.getLoader().height*2;
			this.loaderTree.getLoader().x=gameWidth/7;
			this.loaderTree.getLoader().width=gameWidth/1.1;
			this.loaderTree.getLoader().height=gameHeight/1.3;
			addChild(loaderTree.getLoader());
		}
	}
}