package balloongame
{
	import caurina.transitions.*;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import library.MyLoader;

	public class Gift extends Sprite
	{
		private var wordLoader:Loader;
		private var labelLoader:Loader;
		private var wordMyLoader:MyLoader;
		private var labelMyLoader:MyLoader;
		private var giftWidth:Number;
		private var giftHeight:Number;
	
		public function Gift(width:Number,height:Number,word:String)
		{
			this.giftWidth = width;
			this.giftHeight = height;
			word = "../content/voice1/cvc/"+word+"/flashcard/cover_c_200x100.png";
			labelMyLoader = new MyLoader("../images/frame3.png",{width:50,height:30});
			wordMyLoader = new MyLoader(word,{width:50,height:30});
			labelLoader = labelMyLoader.getLoader();
			wordLoader = wordMyLoader.getLoader();
			addChild(labelLoader);
			addChild(wordLoader);
			this.addEventListener(Event.ENTER_FRAME,onEachFrame);
		}
		private function onEachFrame(e:Event):void{
			if(checkLoad()){
				Tweener.addTween(this,{y:this.y+Math.random()*200,time:20});
			}
		}
		public function checkLoad():Boolean{
			if(wordMyLoader.isLoaded&&labelMyLoader.isLoaded){
				return true;
			}
			else{
				return false;
			}
		}
	}
}