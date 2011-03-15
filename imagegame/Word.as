package imagegame
{
	import flash.display.*;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class Word extends Sprite
	{
		//var
		private var imageURL:String;
		private var soundURL:String;
		private var word:String;
		private var isWordCorrect:Boolean = false;		
		//sound and images
		private var wordSound:Sound;
		private var image:Bitmap;
		//position of mc(optional)	
		private var coordinateX:Number;
		private var coordinateY:Number;
		public function Word(word:String,coordinateX:Number,coordinateY:Number):void
		{
			this.word = word;
			this.soundURL = "../content/voice1/ck/"+word+"/audio/"+word+".mp3";
			this.imageURL = "../content/voice1/ck/"+word+"/flashcard/cover_c_200x100.png";
			this.x = coordinateX;
			this.y = coordinateY;
			loadImage();
			loadSound();
		}
		private function loadImage():void{
			var url:URLRequest = new URLRequest(imageURL);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoadComplete);
			loader.load(url);
		}
		private function onImageLoadComplete(event:Event):void{
			image = new Bitmap(event.target.content.bitmapData);
			addChild(image);
			image.height = 50;
			image.width = 150;
		}
		private function loadSound():void{
			var url:URLRequest = new URLRequest(soundURL);
			wordSound = new Sound();
			wordSound.load(url);	
		}
		//play sound of the word 
		public function playSound():void{
			wordSound.play();
		}
		//functions to check whether word is correctly picked
		public function setWordCorrect(isCorrect:Boolean):void{
			this.isWordCorrect = isCorrect;
		}
		public function checkWord():Boolean{
			return this.isWordCorrect;
		}
		private var loaderCorrectMark:Loader;
		private var loaderWrongMark:Loader;
		public function setMark():void{
			//add correct mark if it's correct word
			var urlCorrectMark:URLRequest = new URLRequest("../images/imagegame/correct.gif");
			var urlWrongMark:URLRequest = new URLRequest("../images/imagegame/wrong.gif");
			loaderCorrectMark = new Loader();
			loaderWrongMark = new Loader();
			loaderCorrectMark.contentLoaderInfo.addEventListener(Event.COMPLETE,onCorrectMarkCompleteEvent);
			loaderWrongMark.contentLoaderInfo.addEventListener(Event.COMPLETE,onWrongMarkCompleteEvent);
			if(this.isWordCorrect){
				loaderCorrectMark.load(urlCorrectMark);
				//addChild(loaderCorrectMark);
			}
			else{
				loaderWrongMark.load(urlWrongMark);
				//addChild(loaderWrongMark);
			}
			
		}
		private function onCorrectMarkCompleteEvent(event:Event):void{
			loaderCorrectMark.height = 15;
			loaderCorrectMark.width = 15;
			loaderCorrectMark.x = image.x + image.width - 50;
			loaderCorrectMark.y = image.y + 10;
			addChild(loaderCorrectMark);
		}
		private function onWrongMarkCompleteEvent(event:Event):void{
			loaderWrongMark.height = 15;
			loaderWrongMark.width = 15;
			loaderWrongMark.x = image.x + image.width - 50;
			loaderCorrectMark.y = image.y + 10;
			addChild(loaderWrongMark);
		}
		public function getWordName():String{
			return this.word;
		}
	}
}
