package treeGame
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.*;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	
	import org.osmf.events.TimeEvent;

	public class Word extends Sprite
	{
		//var
		private var wordURL:String;
		private var soundURL:String;
		private var congratURL:String;
		private var soundExURL:String;
		private var soundWrongURL:String;
		private var word:String;
		//sound and images of word and letter
		private var wordSound:Sound;
		private var excellent:Sound;
		private var wrong:Sound;
		private var wordImage:Bitmap;

		private var coordinateX:Number;
		private var coordinateY:Number;
		private var loaderCongrat:MyBitmapLoader;
		private var gameWidth:Number;
		private var gameHeight:Number;
	
		private var letterArray:Array = new Array();
		public function Word(word:String,coordinateX:Number,coordinateY:Number,gameWidth:Number,gameHeight:Number):void
		{
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			this.word = word;
			this.soundURL = "../content/voice1/ccvc/"+word+"/audio/"+word+".mp3";
			this.soundExURL="../sound/excellent.mp3";
			this.soundWrongURL="../sound/wrongSound.mp3";
			this.wordURL = "../content/voice1/ccvc/"+word+"/flashcard/cover_c_200x100.png";
			this.loaderCongrat = new MyBitmapLoader("../images/treegame/congrat.gif");
			this.loaderCongrat.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedCongrat);
			this.x = coordinateX;
			this.y = coordinateY;
			this.loadSound();
			this.loadLetter();
			this.loadSoundEx();
			this.loadSoundWrong();			
		}

		//load sound
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundURL);
			wordSound = new Sound();
			wordSound.load(url);	
		}
		private function loadSoundEx():void{
			var url:URLRequest = new URLRequest(soundExURL);
			excellent = new Sound();
			excellent.load(url);	
		}
		private function loadSoundWrong():void{
			var url:URLRequest = new URLRequest(soundWrongURL);
			wrong = new Sound();
			wrong.load(url);	
		}
		//play sound of the word 
		public function playSound():void{
			wordSound.play();
		}
		public function playExcellent():void{
			excellent.play();
		}
		public function playWrong():void{
			wrong.play();
		}

		private function loadImage():void{
			var url:URLRequest = new URLRequest(wordURL);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoadComplete);
			loader.load(url);
		}
		private function onImageLoadComplete(event:Event):void{
			wordImage = new Bitmap(event.target.content.bitmapData);
			wordImage.x=gameWidth/4;
			wordImage.y=gameHeight/20;
			wordImage.width=gameWidth/2.8;
			wordImage.height=gameHeight/3.5;
			addChild(wordImage);
		}
		
		private function onLoadedCongrat(event:Event):void{
			this.loaderCongrat.getLoader().x=gameWidth/3;
			this.loaderCongrat.getLoader().y=gameHeight/5;
			this.loaderCongrat.getLoader().width=gameWidth/2;
			this.loaderCongrat.getLoader().height=gameHeight/3;
		}

		//Load letters in XML file
		private var xmlLoader:URLLoader = new URLLoader();
		private var xmlData:XML = new XML();
		private function loadLetter():void{
			xmlLoader.addEventListener(Event.COMPLETE,onLoadXML);
			xmlLoader.load(new URLRequest("../content/voice1/ccvc/"+word+"/games/wordElement/wordElement.xml"));
		}
		private function onLoadXML(event:Event):void{
			xmlData = new XML(event.target.data);
			parseLetter(xmlData);
		}

		private function parseLetter(data:XML):void{
			var letterList:XMLList = data.element;
			for (var i:Number = 0; i < letterList.length(); i++){
				letterArray.push(data.element[i]);
			}
			for (var k:Number = 0; k < letterArray.length; k++){
				var num:Number = this.randomNumber();
				var letter:Letter = new Letter(letterArray[k],gameWidth/2.5+k*100,gameWidth/20+num*20,k,gameWidth,gameHeight);
				addChild(letter);
				letter.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			}			
			}
		//Random number for random position
		private var numArray:Array = [0,1,2,3,4,5,6,7,8,9,10];
		private var largest:Number = 10;
		private function randomNumber():Number{
			var random:Number = Math.floor(Math.random()*(1+largest-0))+0;
			var returnNum:Number = numArray[random];
			numArray.splice(random,1);
			largest--;
			return returnNum;
		}
		
		public var time:Number=0;
		private function onMouseOver(e:Event):void{			
			if(time==e.currentTarget.order){
				e.currentTarget.playSound();
				e.target.visible = false;
				time++;				
			}
		
			else{
				playWrong();

		}
			if(time==4){
				var timer1:Timer=new Timer(500,1);
				var onCorrectWord1:Function = function (event:TimerEvent):void{
					loadImage();
					playSound();
					var timer:Timer=new Timer(1000,1);
					var onCorrectWord:Function = function (event:TimerEvent):void{
						addChild(loaderCongrat.getLoader());
						playExcellent();
					}
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord);
					timer.start();
				}				
				timer1.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord1);
				timer1.start();
			}
			
		}
		}
		
	}
