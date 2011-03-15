package imagegame
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.display.Stage;

	public class Instructor extends Sprite
	{
		public var loaderMinion:Loader;
		public var loaderPikachu:Loader;
		private var loaderSpeech:Loader;
		private var box:TextField;
		
		public function Instructor()
		{
			loadMinionImage();
			loadPikachu();
			//loadSpeechImage();
			//loadTextBox();
		}
		public function loadMinionImage():void{
			var url:URLRequest = new URLRequest("../images/imagegame/pikachu1.gif");
			loaderMinion = new Loader();
			loaderMinion.contentLoaderInfo.addEventListener(Event.COMPLETE,onMinionImageLoadComplete);
			loaderMinion.load(url);
		}
		public function loadPikachu():void{
			var url:URLRequest = new URLRequest("../images/imagegame/pikachu2.gif");
			loaderPikachu = new Loader();
			loaderPikachu.contentLoaderInfo.addEventListener(Event.COMPLETE,onPikachuImageLoadComplete);
			loaderPikachu.load(url);
		}
		private function loadSpeechImage():void{
			var url:URLRequest = new URLRequest("../images/imagegame/bubbleTalk1.gif");
			loaderSpeech = new Loader();
			loaderSpeech.contentLoaderInfo.addEventListener(Event.COMPLETE,onSpeechImageLoadComplete);
			loaderSpeech.load(url);
		}
		private function loadTextBox():void{
			box = new TextField;
			addChild(box);
		}
		private function onMinionImageLoadComplete(event:Event):void{
			addChild(loaderMinion);
			loaderMinion.height = 100;
			loaderMinion.width = 100;
			loaderMinion.x = stage.width / 2;
		}
		private function onPikachuImageLoadComplete(event:Event):void{
			addChild(loaderPikachu);
			loaderPikachu.height = 100;
			loaderPikachu.width = 100;
			loaderPikachu.x = stage.width / 2;
			loaderPikachu.visible = false;
		}
		private function onSpeechImageLoadComplete(event:Event):void{
			addChild(loaderSpeech);
			loaderSpeech.height = 50;
			loaderSpeech.width = 300;
		}
		//function to pick a random word from array of words
		//algorithm: Math.floor(Math.random()*(1+High-Low))+Low;
		private function pickRanWord():Number{
			var random:Number = Math.floor(Math.random()*(1+3-0))+0;
			return random;
		}
		//function to play random word sound and return index of the word in vector list
		public function playRanWordSound(wordList:Vector.<Word>):Number{
			var random:Number = Math.floor(Math.random()*(1+wordList.length-1-0))+0;
			wordList[random].playSound();
			return random;
		}
	}
}