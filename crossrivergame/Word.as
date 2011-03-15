package crossrivergame
{
	import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.*;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	
	public class Word extends Sprite {
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var bridge:MyBitmapLoader;
		private var turtle:MyBitmapLoader;
		private var word:String;
		private var wordLoader:MyBitmapLoader;
		private var soundURL: String;
		private var wordX:Number;
		private var wordY:Number;
		private var wordSound:Sound;
		private var excellent:Sound;
		private var wrong:Sound;
		private var soundWrongURL:String;
		private var soundExURL:String;
		private var wordImage:Bitmap;
		private var ranLetter:Array=["a","h","n","v","b"];
		private var letterArray:Array=new Array();
		
	{
		public function Word(word:String,wordX:Number,wordY:Number,gameWidth:Number,gameHeight:Number){
		this.gameWidth = gameWidth;
		this.gameHeight = gameHeight;
		this.word=word;
		this.x=wordX;
		this.y=wordY;
		this.soundWrongURL="../sound/beep.mp3";
		this.soundURL = "../content/voice1/consonantblends/"+word+"/audio/"+word+".mp3";
		this.wordLoader =new MyBitmapLoader( "../content/voice1/consonantblends/"+word+"/flashcard/cover_c_200x100.png");	
		this.wordLoader.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedWord);
		this.bridge=new MyBitmapLoader("../images/crossrivergame/bridge.gif");
		this.bridge.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedBridge);
		this.turtle= new MyBitmapLoader("../images/crossrivergame/turtle.gif")
		this.turtle.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedTurtle);	
		this.addChild(turtle.getLoader());
		this.loadSound();
		this.loadLetter();	
		this.soundExURL="../sound/goodjob.mp3";
		this.loadSoundEx();
		this.loadSoundWrong();
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundURL);
			wordSound = new Sound();
			wordSound.load(url);	
		}
		public function playSound():void{
			wordSound.play();
		}
		private function loadSoundEx():void{
			var url:URLRequest = new URLRequest(soundExURL);
			excellent = new Sound();
			excellent.load(url);	
		}
		public function playExcellent():void{
			excellent.play();
		}
		private function loadSoundWrong():void{
			var url:URLRequest = new URLRequest(soundWrongURL);
			wrong = new Sound();
			wrong.load(url);	
		}
		public function playWrong():void{
			wrong.play();
		}
		private function onLoadedWord(event:Event):void{
			wordLoader.getLoader().x=gameWidth/2.95;
			wordLoader.getLoader().y=gameHeight/3.35;
		}
		private function onLoadedBridge(e:Event):void{
			bridge.getLoader().x=gameWidth-bridge.getLoader().width*2.143;
			bridge.getLoader().y=gameHeight-bridge.getLoader().width*1.285;
			bridge.getLoader().width=gameWidth/1.755;
			bridge.getLoader().height=gameHeight/10;			
		}
		private function onLoadedTurtle(event:Event):void{
			addChild(turtle.getLoader());
			turtle.getLoader().height=gameHeight/6;
			turtle.getLoader().width=gameWidth/7;
			turtle.getLoader().x=gameWidth/13;
			turtle.getLoader().y=gameHeight-bridge.getLoader().width*1.519;
			
		}
		private function runTurtle():void{
			Tweener.addTween(this.turtle.getLoader(),{x:this.turtle.getLoader().x+gameWidth/1.7,time:4});
		}

		//Load letters in XML file
		private var xmlLoader:URLLoader = new URLLoader();
		private var xmlData:XML = new XML();
		private function loadLetter():void{
			xmlLoader.addEventListener(Event.COMPLETE,onLoadXML);
			xmlLoader.load(new URLRequest("../content/voice1/consonantblends/"+word+"/games/wordElement/wordElement.xml"));
		}
		private function onLoadXML(event:Event):void{
			xmlData = new XML(event.target.data);
			parseLetter(xmlData);
		}
		private var doOne:Number =0;
		private function parseLetter(data:XML):void{
			var letterList:XMLList = data.element;
			for (var i:Number = 0; i < letterList.length(); i++){
				letterArray.push(data.element[i]);
			}
			
			for (var k:Number = 0; k < letterArray.length; k++){
				var letter:Letter = new Letter(letterArray[k],150+k*110,gameHeight/1.27,k,gameWidth,gameHeight);
				addChild(letter);
				if(k!==4){
				letter.addEventListener(MouseEvent.CLICK,onMouseClick);
			}
				if(k==4){
					letter.addEventListener(MouseEvent.CLICK,onClick);
				}		
				var randomLetter:Letter=new Letter(ranLetter[this.pickRandomLetter()],gameWidth/1.22,gameHeight/1.27,5,gameWidth,gameHeight);
				if(doOne==0){
				addChild(randomLetter);
				randomLetter.addEventListener(MouseEvent.CLICK,onClickWrong);
				doOne++;
			}
				}
			}	
		}
		private var numArray:Array = [0,1,2,3,4];
		private var largest:Number = 4;
		private function pickRandomLetter():Number{
			var random:Number = Math.floor(Math.random()*(1+largest-0))+0;
			var returnNum:Number = numArray[random];
			numArray.splice(random,1);
			largest--;
			return returnNum;
		}
		private function onMouseClick(e:MouseEvent):void{
			e.currentTarget.playSoundLetter();
		}
		private var done:Number = 0;
		private function onClick(e:MouseEvent):void{
			if(done==0){
				e.currentTarget.playSoundLetter();
				Tweener.addTween(e.currentTarget,{x:e.currentTarget.x-gameWidth/3.1,time:3});
				var timer1:Timer=new Timer(1000,1);
				var onCorrectWord1:Function = function (event:TimerEvent):void{
					addChild(bridge.getLoader());				
					addChild(wordLoader.getLoader());
					playSound();
					var timer2:Timer=new Timer(800,1);
					var onCorrectWord2:Function = function (event:TimerEvent):void{
					runTurtle();
					}
					timer2.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord2);
					timer2.start();
					var timer:Timer=new Timer(2000,1);
					var onCorrectWord:Function = function (event:TimerEvent):void{
						excellent.play();
					}
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord);
					timer.start();
					done++;
			}
			}				
			timer1.addEventListener(TimerEvent.TIMER_COMPLETE,onCorrectWord1);
			timer1.start();
		}
		private function onClickWrong(e:MouseEvent):void{
			e.currentTarget.playSoundLetter();
			var timerWrong:Timer=new Timer(600,1);
			var onWrongLetter:Function = function (event:TimerEvent):void{
				playWrong();
			}
			Tweener.addTween(e.currentTarget,{y:e.currentTarget.y-1000,time:40});
			timerWrong.addEventListener(TimerEvent.TIMER_COMPLETE,onWrongLetter);
			timerWrong.start();
		}
	}
}
