package flipgame
{
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
	import flash.events.*;
	import flash.net.URLRequest;
	
	import imagegame.Word;

	public class FlipGameMain extends Sprite
	{
		//iVars
		private var scene:Scene3D;  
		private var camera:Camera3D;  
		private var view:View3D;  
		//stage vars
		private var stageWidth:Number;
		private var stageHeight:Number;
		private var cardArray:Array = ["bed","box","bag"];
		
		private var card:Card;
		private var secCard:Card;
		private var thirdCard:Card;
		private var firstCardDis:ObjectContainer3D;
		
		public function FlipGameMain(stageWidth:Number,stageHeight:Number)
		{
			this.stageHeight = stageHeight;
			this.stageWidth = stageWidth;
			this.initAway3D();
			card = new Card(100,120,cardArray[0],"card1");
			secCard = new Card(100,120,cardArray[1],"card2");
			thirdCard = new Card(100,120,cardArray[2],"card3");
			this.addEventListener(Event.ENTER_FRAME,render);
		}
		private function initAway3D():void{
			this.scene = new Scene3D();
			camera = new Camera3D();
			camera.y = 700;
			camera.z = 500;
			camera.lookAt(new Number3D(0,0,0));
			
			this.view = new View3D({scene:scene,camera:camera});
			this.view.x = this.stageWidth/2;
			this.view.y = this.stageHeight/2;
			addChild(view);
		}	
		private var doOne:Number = 0;
		private function render(e:Event):void{
			if(doOne==0){
				if(card.isAllLoaded()&&secCard.isAllLoaded()&&thirdCard.isAllLoaded()){
					this.scene.addChild(card.createCard(-50,-stageHeight/2));
					this.scene.addChild(secCard.createCard(50,-stageHeight/2));
					this.scene.addChild(thirdCard.createCard(150,-stageHeight/2));
					//face up all the cards
					this.card.faceUpCard();
					this.secCard.faceUpCard();
					this.thirdCard.faceUpCard();
					//call pics of card
					var ranNum:Number = this.pickRanCard();
					switch (ranNum)
					{
						case 0:
							this.addPicToScene(card);
							break;
						case 1:
							this.addPicToScene(secCard);
							break;
						case 2:
							this.addPicToScene(thirdCard);
							break;
					}
					
					doOne+=1;
				}
			}
			this.view.render();
		}
		private function addPicToScene(card:Card):void{
			card.setCard(true);
			var pic:Loader = card.callCardPic();
			pic.alpha = 0;
			pic.y = stageHeight/2 - pic.height;
			addChild(pic);
			Tweener.addTween(pic,{alpha:1,time:3,x:this.stageWidth/2});
		}
		private function pickRanCard():Number{
			var random:Number = Math.floor(Math.random()*(1+2-0))+0;
			return random;
		}
	}
}