package balloongame
{
	import caurina.transitions.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	import library.MyLoader;

	public class Balloon extends Sprite
	{
		//iVars
		private var balloonWidth:Number;
		private var balloonHeight:Number;
		
		public var mc_balloon:MovieClip;
		private var loader:Loader;
		
		public var isLoaded:Boolean;
		
		public function Balloon(width:Number,height:Number)
		{
			this.balloonWidth = width;
			this.balloonHeight = height;
			loader = new MyLoader("../swf/balloon.swf",{width:width,height:height}).getLoader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
		}
		private function onLoaded(e:Event):void{
			isLoaded = true;
			mc_balloon = new MovieClip();
			mc_balloon = e.currentTarget.content;
			mc_balloon.width = balloonWidth;
			mc_balloon.height = balloonHeight;
			addChild(mc_balloon);
			mc_balloon.addEventListener(Event.ENTER_FRAME,onEachFrame);
		}
		private function onEachFrame(e:Event):void{
			if(mc_balloon.currentFrame==38){
				mc_balloon.gotoAndPlay(1);
			}
			else if(mc_balloon.currentFrame==74){
				mc_balloon.gotoAndPlay(39);
			}
		}
		public function flyToRight():void{
			if(mc_balloon.currentFrame>1&&mc_balloon.currentFrame<39){
				
			}
			else{
				mc_balloon.gotoAndPlay(1);	
			}
		}
		public function flyToLeft():void{
			if(mc_balloon.currentFrame>39){
				
			}
			else{
				mc_balloon.gotoAndPlay(39);	
			}
		}
	}
}