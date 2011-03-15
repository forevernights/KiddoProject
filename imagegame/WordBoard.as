package imagegame
{		
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	public class WordBoard extends MovieClip
	{
		//private var words:Array = ["back","ck","click","clock"];
		private var words:Array = [];
		private var shuffleWords:Array = [];
		private var wordList:Vector.<Word> = new Vector.<Word>;
		public function WordBoard(words:Array)
		{
			this.words = words;
			addWordToBoard(words);
		}
		private function addWordToBoard(arrayOfWords:Array):void{
			wordList = new <Word>[];
			var wordX:Number = 0;
			var wordY:Number = 0;
			for(var i:Number = 0; i < arrayOfWords.length; i++){
				if(i==0){
					wordX = 0;
					wordY = 100;
				}
				else if(i%4==0&&i!=0){
					wordX = 0;
					wordY +=50;
				}
				else{
					wordX +=100;
				}
				var word:Word = new Word(arrayOfWords[i],wordX,wordY);
				wordList.push(word);
			}		
			var myFunction:Function = function(item:Word, index:int, vector:Vector.<Word>):void {
				addChild(item);
				item.addEventListener(MouseEvent.CLICK,onWordClick);
			};
			wordList.forEach(myFunction, this);
		}
		private function populateDisplayListFromVector():void{
			var myFunction:Function = function(item:Word, index:int, vector:Vector.<Word>):void {
				addChild(item);
				item.addEventListener(MouseEvent.CLICK,onWordClick);
			};
			wordList.forEach(myFunction, this);
		}
		private function onWordClick(event:MouseEvent):void{
			var word:Word = event.target as Word;
			trace(word.checkWord());
			word.setMark();
			if(word.checkWord()){
				var newTimer:Timer = new Timer(1000,1);
				var onCorrectWord:Function = function(event:TimerEvent):void{
					//small function to shuffle and rearrage the array of words...
					while (words.length > 0) {
						shuffleWords.push(words.splice(Math.round(Math.random() * (words.length - 1)), 1)[0]);
					}
					while(numChildren!=0){removeChildAt(0);}
					addWordToBoard(shuffleWords);
					words = shuffleWords;
					shuffleWords = [];
					wordList[wordList.indexOf(word,0)].setWordCorrect(true);
				}
				newTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord);
				newTimer.start();
			}
			else{
				var timer:Timer = new Timer(1000,1);
				var onWrongWord:Function = function(event:TimerEvent):void{
					while(numChildren!=0){removeChildAt(0);}
					wordList.splice(wordList.indexOf(word,0),1);
					var myFunction:Function = function(item:Word, index:int, vector:Vector.<Word>):void {
						addChild(item);
						item.addEventListener(MouseEvent.CLICK,onWordClick);
					};
					wordList.forEach(myFunction,wordList);
				}
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,onWrongWord);
				timer.start();	
			}
		}
		
		/*private function onWordClick(event:MouseEvent):void{
			var target:Word = event.target as Word;
			target.playSound();
			//halt the animation for a while using timer, do something more complicated here later
			//increase time interval for more complex animation
			var timer:Timer = new Timer(1000,2);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			timer.start();
		}
		private function onTimerComplete(event:TimerEvent):void{
			//small function to shuffle and rearrage the array of words...
			while (words.length > 0) {
				shuffleWords.push(words.splice(Math.round(Math.random() * (words.length - 1)), 1)[0]);
			}
			while(this.numChildren!=0){this.removeChildAt(0);}
			addWordToBoard(shuffleWords);
			words = shuffleWords;
			shuffleWords = [];
		}*/
		public function retrieveWordList():Vector.<Word>{
			return this.wordList;
		}
		
	}
}