package egggame{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.*;
	import flash.utils.Timer;
	import caurina.transitions.*;
	import library.MyBitmapLoader;
	import org.osmf.events.TimeEvent;
	
	public class Word extends Sprite{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var vowel:String;
		public var word:String;
		private var praiseSound:Sound;
		private var wordSound:Sound;
		private var bellSound:Sound;
		private var buzzSound:Sound;
		private var soundURL:String;
		private var praiseSoundURL:String;
		private var vowelSoundURL:String;
		private var bellSoundURL:String;
		private var buzzSoundURL:String;
		private var wordLoader:MyBitmapLoader;
		private var letterArray:Array = new Array();
		private var vowelArray:Array = ["a","e","i","o","u"];
		
		public function Word(locationX:Number,locationY:Number,word:String,gameWidth:Number,gameHeight:Number):void{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.x = locationX;
			this.y = locationY;
			this.word = word;
			this.vowel = vowel;
			this.soundURL = "../content/voice1/cvcc/"+word+"/audio/"+word+".mp3";
			this.bellSoundURL = "../sound/bell.mp3";
			this.praiseSoundURL = "../sound/wellDone.mp3";
			this.buzzSoundURL = "../sound/bounce.mp3";
			this.wordLoader = new MyBitmapLoader("../content/voice1/cvcc/"+word+"/flashcard/cover_bw_200x100.png");
			this.wordLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedWord);	
			addChild(wordLoader.getLoader());

			loadSound();
			loadLetter();
			loadBellSound();
			loadPraiseSound();
			loadBuzzSound();
		}
		private function onLoadedWord(e:Event):void{
			this.wordLoader.getLoader().width = gameWidth/4;
			this.wordLoader.getLoader().height = gameHeight/5;
			this.wordLoader.getLoader().visible = false;
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundURL);
			wordSound = new Sound();
			wordSound.load(url);	
		}
		public function playSound():void{
			wordSound.play();
		}
		private function loadBellSound():void{
			var url:URLRequest = new URLRequest(bellSoundURL);
			bellSound = new Sound();
			bellSound.load(url);
		}
		public function playBellSound():void{
			bellSound.play();
		}
		private function loadPraiseSound():void{
			var url:URLRequest = new URLRequest(praiseSoundURL);
			praiseSound = new Sound();
			praiseSound.load(url);
		}
		public function playPraiseSound():void{
			praiseSound.play();
		}
		private function loadBuzzSound():void{
			var url:URLRequest = new URLRequest(buzzSoundURL);
			buzzSound = new Sound();
			buzzSound.load(url);
		}
		public function playBuzzSound():void{
			buzzSound.play();
		}
		private var xmlLoader:URLLoader = new URLLoader();
		private var xmlData:XML = new XML();
		
		private function loadLetter():void{
			xmlLoader.addEventListener(Event.COMPLETE,onLoadXML);
			xmlLoader.load(new URLRequest("../content/voice1/cvcc/"+word+"/games/wordElement/wordElement.xml"));
		}
		private function onLoadXML(event:Event):void{
			xmlData = new XML(event.target.data);
			parseLetter(xmlData);
		}
		private var one:Number=0;
		private function parseLetter(data:XML):void{
			var letterList:XMLList = data.element;
			for (var i:Number = 0; i < letterList.length(); i++){
				letterArray.push(data.element[i]);
			}
			for (var m:Number = 0; m < vowelArray.length; m++){
				var vowel:Letter = new Letter(vowelArray[m],200+m*120,50,100,gameWidth,gameHeight);
				addChild(vowel);
				vowel.addEventListener(MouseEvent.CLICK,onVowelClick);
			}
			for (var k:Number = 0; k < letterArray.length; k++){
				var letter:Letter = new Letter(letterArray[k],300+k*90,300,k,gameWidth,gameHeight);
				addChild(letter);
			}
		}
		private function onMouseClick(event:MouseEvent):void{
			event.currentTarget.playVowelSound();
		}
		public var letter:Letter;
		private function onVowelClick(event:MouseEvent):void{	
			var vowel:Letter = event.currentTarget as Letter;
			if(vowel.letter==letterArray[1]){
				playBellSound();
				Tweener.addTween(event.currentTarget,{x:event.currentTarget.x=390,time:1});
				Tweener.addTween(event.currentTarget,{y:event.currentTarget.y=300,time:1});
				var vowelTimer:Timer = new Timer(1000,1);
				var onCorrectVowelSound:Function = function(event:TimerEvent):void{
					vowel.playVowelSound();
				}
				vowelTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectVowelSound);
				vowelTimer.start();
				var bellTimer:Timer = new Timer(1700,1);
				var onCorrectWordSound:Function = function(event:TimerEvent):void{
					playSound();
				}
				bellTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWordSound);
				bellTimer.start();
				var timer:Timer = new Timer(2700,1);
				var onCorrectVowel:Function = function(event:TimerEvent):void{
					playPraiseSound();
				}
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectVowel);
				timer.start();
			}
			else{
				playBuzzSound();
				var secTimer:Timer = new Timer(1200,1);
				var onWrongVowel:Function = function(event:TimerEvent):void{
					vowel.playVowelSound();
				}
				secTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onWrongVowel);
				secTimer.start();
			}   
		}
	}
}