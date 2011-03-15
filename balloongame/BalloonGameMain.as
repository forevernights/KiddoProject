package balloongame
{
	import caurina.transitions.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	import library.MyLoader;

	public class BalloonGameMain extends Sprite
	{
		private var stageWidth:Number;
		private var stageHeight:Number;	
		private var house:MyLoader;
		private var loader:Loader;
		private var balloon:Balloon;
		public function BalloonGameMain(stageWidth:Number,stageHeight:Number)
		{
			Mouse.hide();
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			loader = new MyLoader("../swf/fan.swf",{width:20,height:20}).getLoader();
			var bgLoader:Loader = new MyLoader("../images/balloongame/house1.jpg",{width:stageWidth,height:stageHeight}).getLoader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			balloon = new Balloon(100,100);
			addChild(bgLoader);
			addChild(balloon);	
			balloon.x = 200;
			balloon.y = 100;
			balloon.addEventListener(Event.ENTER_FRAME,onMove);
			this.init();
			this.addEventListener(Event.ENTER_FRAME,onEachFrame);
		}
		private var doOne:Number=0;
		private function onEachFrame(e:Event):void{
			for(var k:Number=0;k<giftList.length;k++){
				if(balloon.hitTestObject(giftList[k])){
					removeChild(giftList[k]);
				}
			}
		}
		private var wordArray:Array = ["bag","bed","bib","bid"];
		private var giftList:Vector.<Gift> = new Vector.<Gift>;
		private function init():void{
			var timer:Timer = new Timer(1000,3);
			timer.addEventListener(TimerEvent.TIMER,onTick);
			timer.start();
		}
		private function onTick(e:TimerEvent):void{
			var n:Number=Math.floor(Math.random()*wordArray.length);
			var gift:Gift = new Gift(100,100,wordArray[n]);
			gift.x = Math.random() * stageWidth;
			addChild(gift);
			giftList.push(gift);
		}
		private function onMove(e:Event):void{
			
		}
		private function onWind(e:Event):void{
			if(balloon.x > mouseX && balloon.y == mouseY){
				Tweener.addTween(balloon,{x:balloon.x + 50});
			}
			else if(balloon.x < mouseX && balloon.y == mouseY){
				Tweener.addTween(balloon,{x:balloon.x - 50});
			}
		}
		private function onLoaded(e:Event):void{
			addChild(loader);
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void{
			var distance:Number = (Math.sqrt(Math.pow(balloon.y - mouseY,2)));
			trace(balloon.y - mouseY);
			if(balloon.x - mouseX > -70 && balloon.x - mouseX < 30){
				if(distance < 70){
					balloon.flyToLeft();
					Tweener.addTween(balloon,{x:balloon.x-60,time:5});
				}
			}
			else if(balloon.x - mouseX < 120 && balloon.x - mouseX > 30){
				if(distance < 70){
					balloon.flyToRight();	
					Tweener.addTween(balloon,{x:balloon.x+60,time:5});
				}
			}
			if(balloon.x >=(stageWidth-balloon.width)){
				balloon.x = stageWidth-balloon.width;
			}
			else if(balloon.x <= 0){
				balloon.x = 0;
			}
			loader.x = mouseX;
			loader.y = mouseY;
		}
	}
}