package bubblegame
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import library.MyBitmapLoader;
	
	public class BubbleBoard extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var correctWord:String;
		public var word:Bubble;
		private var image:Array = new Array();
		private var wordArray:Array = ["bed","pot","fat","bun","six"];
		private var loader:MyBitmapLoader;

		public function BubbleBoard(gameWidth:Number,gameHeight:Number){
			this.addEventListener(Event.ENTER_FRAME,onEachFrame);
			this.loader = new MyBitmapLoader("../images/bubblegame/speaker.gif")
			this.loader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedSpeaker);
			this.loader.getLoader().addEventListener(MouseEvent.CLICK,onSpeakerClick);
			this.addChild(loader.getLoader());
		}
		private var doLoad:Number = 0;
		private function onEachFrame(e:Event):void{
			if(doLoad==0){
				if(loader.isLoaded){
					doLoad++;
					addBubbles(image);
				}	
			}
		}
		private function addBubbles(numberOfBubbles:Array):void{
			for(var i:Number = 0; i < 5; i++){
				var bubble:Bubble = new Bubble(Math.random()*500, Math.random()*250, getRandomSpeed(), getRandomSpeed(), wordArray[i],gameWidth,gameHeight);
				bubble.addEventListener(MouseEvent.CLICK,onClick);
				addChild(bubble);
			}		
		}
		private function onLoadedSpeaker(e:Event):void{
			loader.getLoader().x = 800;
			loader.getLoader().y = 400;
			loader.getLoader().width = 150;
			loader.getLoader().height = 150;
		}
		private var one:Number = 0;
		private function onSpeakerClick(event:MouseEvent): void{
			for(var a:Number=0; a<1; a++){
				if(one==0){
					word = new Bubble(Math.random()*100, Math.random()*100, getRandomSpeed(), getRandomSpeed(), wordArray[this.pickRandomWord()],gameWidth,gameHeight);
					this.pickRandomWord();
					one++;
				}
				word.playSound();
				correctWord = word.word;
			}
		}
		private function onClick(event:MouseEvent):void{
			var bubble:Bubble = event.currentTarget as Bubble;
			if(correctWord==bubble.word){	
				bubble.playBellSound();
				var bellTimer:Timer = new Timer(1000,1);
				var onCorrectWordSound:Function = function(event:TimerEvent):void{
				bubble.playSound();	
				}
				bellTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWordSound);
				bellTimer.start();
				var timer:Timer = new Timer(2000,1);
				var onCorrectWord:Function = function(event:TimerEvent):void{
				removeChild(bubble);
				bubble.playPraiseSound();
				}
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord);
				timer.start();
			}
			else{
				bubble.playBuzzSound();
				var secTimer:Timer = new Timer(1000,1);
				var onWrongWord:Function = function(event:TimerEvent):void{
				word.playSound();
				}
				secTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onWrongWord);
				secTimer.start();
			}
		}
		private function getRandomSpeed():Number{
			var speed:Number = Math.random()*2.5;
			if (Math.random() > .5)
				speed *= -1; 
			return speed;
		}	
		//algorithm: Math.floor(Math.random()*(1+High-Low))+Low;
		private function pickRandomWord():Number{
			var random:Number = Math.floor(Math.random()*(1+4-0))+0;
			return random;
		}	
	}
}