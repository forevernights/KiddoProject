package crossrivergame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	
	public class Background extends Sprite
	{
		private var wall:MyBitmapLoader;
		private var wall1:MyBitmapLoader;
		private var river:MyBitmapLoader;
		private var river1:MyBitmapLoader;
		private var tree:MyBitmapLoader;
		private var sky:MyBitmapLoader;
		private var gameWidth:Number;
		private var gameHeight:Number;
		public function Background(gameWidth:Number,gameHeight:Number)
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.wall1= new MyBitmapLoader("../images/crossrivergame/wall.gif")
			this.wall1.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedWall1);
			this.sky= new MyBitmapLoader("../images/crossrivergame/sky.jpg")
			this.sky.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSky);
			this.river= new MyBitmapLoader("../images/crossrivergame/river.gif")
			this.river.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedRiver);
			this.tree= new MyBitmapLoader("../images/crossrivergame/tree.gif")
			this.tree.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedTree);
			this.wall= new MyBitmapLoader("../images/crossrivergame/wall.gif")
			this.wall.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedWall);

		}
		private function onLoadedSky(event:Event):void{
			addChild(sky.getLoader());
			sky.getLoader().x=0;
			sky.getLoader().y=0;
		}

		private function onLoadedWall(event:Event):void{
			addChild(wall.getLoader());
			wall.getLoader().height=gameHeight/2.95;
			wall.getLoader().width=gameWidth/5;
			wall.getLoader().x=0;
			wall.getLoader().y= gameHeight-wall.getLoader().height*2;
		}
		private function onLoadedWall1(event:Event):void{
			addChild(wall1.getLoader());
			wall1.getLoader().height=gameHeight/2.95;
			wall1.getLoader().width=gameWidth/5;
			wall1.getLoader().x=gameWidth-wall1.getLoader().width*1.75;
			wall1.getLoader().y= gameHeight-wall1.getLoader().height*2;
			
		}
		private function onLoadedRiver(event:Event):void{
			addChild(river.getLoader());
			river.getLoader().height=gameHeight/7;
			river.getLoader().width=gameWidth/2.22;
			river.getLoader().y=wall.getLoader().y+river.getLoader().height*1.37;
			river.getLoader().x=wall.getLoader().width;
		}
		private function onLoadedTree(e:Event):void{
			addChild(tree.getLoader());
			tree.getLoader().x=gameWidth-tree.getLoader().width*0.65;
			tree.getLoader().y=gameHeight-tree.getLoader().height;
			tree.getLoader().height=gameHeight/1.7;
			tree.getLoader().width=gameWidth/4.3;
		}
	}
}