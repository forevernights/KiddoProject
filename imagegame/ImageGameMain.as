package imagegame
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import library.Alert;

	public class ImageGameMain extends MovieClip
	{
		private var words:Array = ["back","ck","click","clock","crack","crick","crock","deck","dock"];
		private var instructor:Instructor = new Instructor();
		private var board:WordBoard = new WordBoard(words);
		public function ImageGameMain()
		{
		 	initGame();
		}
		
		private function initGame():void{
			addChild(instructor);
			addChild(board);
			instructor.addEventListener(MouseEvent.CLICK,onClickMinionEvent);
			instructor.loaderMinion.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			instructor.loaderPikachu.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		private function onClickMinionEvent(event:MouseEvent):void{
			var wordList:Vector.<Word> = board.retrieveWordList();
			var wordIndex:Number = 0;
			if(wordList.length == words.length){
				wordIndex = instructor.playRanWordSound(wordList);
				wordList[wordIndex].setWordCorrect(true);
			}
			else{
				wordList[wordIndex].playSound();
				wordList[wordIndex].setWordCorrect(true);
			}
		}
		private function onMouseOver(event:MouseEvent):void{
			instructor.loaderPikachu.visible = true;
			instructor.loaderMinion.visible = false;
		}
		private function onMouseOut(event:MouseEvent):void{
			instructor.loaderMinion.visible = true;
			instructor.loaderPikachu.visible = false;
		}
	}
}