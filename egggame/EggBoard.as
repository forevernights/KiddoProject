package egggame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import library.MyBitmapLoader;
	
	public class EggBoard extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		public var word:Word;
		public var letter:Letter;
		private var image:Array = new Array();
		private var wordArray:Array = ["best","camp","pond","list"];
		private var vowelArray:Array = ["a","e","i","o","u"];
		private var speakerLoader:MyBitmapLoader;
		private var letterArray:Array = new Array();
		
		public function EggBoard(gameWidth:Number,gameHeight:Number){
			this.speakerLoader = new MyBitmapLoader("../images/bubblegame/speaker.gif");
			this.speakerLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSpeaker);
			this.speakerLoader.getLoader().addEventListener(MouseEvent.CLICK,onSpeakerClick);
			this.addEventListener(Event.ENTER_FRAME,onEachFrame);
		}
		private var doLoad:Number = 0;
		private function onEachFrame(e:Event):void{
			if(doLoad==0){
				if(speakerLoader.isLoaded){
					doLoad++;
				}	
			}
		}
		private function addWord(numberOfWord:Array):void{
			for(var i:Number = 0; i < 4; i++){
				var word:Word = new Word(10,100,wordArray[i],gameWidth,gameHeight);
				addChild(word);
			}		
		}
		private function onLoadedSpeaker(e:Event):void{
			this.speakerLoader.getLoader().x = 800;
			this.speakerLoader.getLoader().y = 400;
			this.speakerLoader.getLoader().height = 150;
			this.speakerLoader.getLoader().width = 150;
			addChild(speakerLoader.getLoader());
		}
		private var one:Number = 0;
		private function onSpeakerClick(event:MouseEvent): void{
			for(var a:Number=0; a<1; a++){
				if(one==0){
					word = new Word(10,100,wordArray[this.pickRandomWord()],gameWidth,gameHeight);
					this.addChild(word);
					one++;
				}
				word.playSound();
				if(letterArray[1]){
				letterArray.visible = false;
				}
			}
		}
		private function pickRandomWord():Number{
			var random:Number = Math.floor(Math.random()*(1+3-0))+0;
			return random;
		}		
	}
}