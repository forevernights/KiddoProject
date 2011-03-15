package
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
	import flash.display.Sprite;
	
	import flipgame.Card;
	import flipgame.FlipGameMain;
	
	import library.MyBitmapLoader;
	
	
	public class KiddoProject extends Sprite
	{
		//[Embed(source="../images/flipgame/card1.gif")]
		//public var IMG:Class;
		public function KiddoProject()
		{
			//var pic:Bitmap = new IMG();
			//addChild(pic);
			var flipgame:FlipGameMain = new FlipGameMain(stage.stageWidth,stage.stageHeight);
			addChild(flipgame);
		}
	}
}