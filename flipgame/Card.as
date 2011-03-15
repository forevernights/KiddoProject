package flipgame{
	
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.math.Number3D;
	import away3d.materials.*;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	
	import caurina.transitions.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import library.MyBitmapLoader;
	

	public class Card{

		private var frontTexture:BitmapData;
		private var backTexture:BitmapData;
		private var bgTexture:BitmapData;
		
		private var cardHeight:int =0;
		private var cardWidth:int=0;

		private var word:String="";
		
		private var scene:Scene3D;  
		private var camera:Camera3D;  
		private var view:View3D;  
		
		private var backLoader:MyBitmapLoader;
		private var frontLoader:MyBitmapLoader;
		private var wordLoader:MyBitmapLoader;
		private var picLoader:MyBitmapLoader;
		
		private var isCardCorrect:Boolean=false;
		private var coorX:Number;
		private var coorY:Number;
		public function Card(cardWidth:int,cardHeight:int,whichWord:String,whichCard:String){
			this.cardHeight = cardHeight;
			this.cardWidth = cardWidth;
			this.word = whichWord;
			backLoader = new MyBitmapLoader("../images/flipgame/"+whichCard+".gif");
			frontLoader = new MyBitmapLoader("../images/flipgame/flipCardBack.jpg");
			wordLoader = new MyBitmapLoader("../content/voice1/cvc/"+whichWord+"/flashcard/cover_c_200x100.png");
			picLoader = new MyBitmapLoader("../content/voice1/cvc/"+whichWord+"/flashcard/pictureCard.jpg");
		}
		
		private var thisCard:ObjectContainer3D;
		public function createCard(coorX:Number,coorY:Number):ObjectContainer3D {  
			if(this.isAllLoaded()){
				this.coorX = coorX;
				this.coorY = coorY;
				var card:ObjectContainer3D = new ObjectContainer3D(); 
				backTexture = new BitmapData(backLoader.width,backLoader.height);
				backTexture = backLoader.getBitmaData();
				frontTexture = new BitmapData(frontLoader.width,frontLoader.height);
				frontTexture = frontLoader.getBitmaData();
				var matrix:Matrix = new Matrix();
				matrix.scale(2,2.6);
				frontTexture.draw(wordLoader.getLoader(),matrix);
				var front:Plane = new Plane({width:cardWidth,height:cardHeight, material: new BitmapMaterial(this.frontTexture,{smooth:true})});
				var back:Plane = new Plane({width:cardWidth,height:cardHeight, material: new BitmapMaterial(this.backTexture,{smooth:true})});
				front.rotationY=180;
				//front.rotationZ = 180;
				back.rotationZ=180;
				back.rotationY=180; 
				
				back.extra = {};
				back.extra.targetCard = card;
				back.addOnMouseDown(onBackClicked);  
				
				
				card.rotationZ=180;
				card.addChild(front);  
				card.addChild(back);
				card.ownCanvas = true;  
				card.x = coorX;
				card.y = coorY;
				thisCard = card;
				return card;	
			}
			else{
				trace("Not all resource is loaded");
				return null;
			}
		}  		
		public function isAllLoaded():Boolean{
			if(backLoader.isLoaded&&frontLoader.isLoaded&&wordLoader.isLoaded){
				return true;
			}
			else{
				return false;
			}
		}
		private var selectedCard:Plane;
		private function onBackClicked(e:Event):void{ 
			Tweener.addTween(e.currentTarget.extra.targetCard, {y:coorY+50,rotationZ:0,time:1});
			selectedCard = e.currentTarget as Plane;
			if(this.isCardCorrect){
				
			}
			else{
				check();		
			}
		} 
		private function check():void{
			var timer:Timer = new Timer(1000,2);
			timer.addEventListener(TimerEvent.TIMER,onTimerStart);
			timer.start();
		}
		private function onTimerStart(e:TimerEvent):void{
			Tweener.addTween(selectedCard.extra.targetCard,{y:coorY,rotationZ:180,time:1});
			selectedCard = null;
		}
		public function faceUpCard():void{
			Tweener.addTween(thisCard,{y:coorY,rotationZ:0,time:3});
			var timer:Timer = new Timer(1000,3);
			var localFunction:Function = function(e:TimerEvent):void{
				Tweener.addTween(thisCard,{y:coorY,rotationZ:180,time:3});
			};
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,localFunction);
			timer.start();
		}
		
		public function callCardPic():Loader{
			var loader:Loader = new Loader();
			loader = picLoader.getLoader();
			loader.height = 100;
			loader.width = 100;
			return loader;
		}
		public function setCard(isCorrectOrWrong:Boolean):void{
			this.isCardCorrect = isCorrectOrWrong;
		}
		public function whatAmI():String{
			return this.word;
		}
	}
}