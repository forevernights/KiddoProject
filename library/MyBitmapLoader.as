package library
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class MyBitmapLoader
	{
		private var url:URLRequest;
		private var loader:Loader;
		private var bitmap:Bitmap;
		private var bitmapdata:BitmapData;
		public var isLoaded:Boolean=false;
		public var width:Number;
		public var height:Number;
		public function MyBitmapLoader(path:String)
		{
			//class to load to work with bitmap images and bitmap data
			this.url = new URLRequest(path);
			this.loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			loader.load(url);
		}
		public function onLoaded(e:Event):void{
			isLoaded = true;
			bitmap = new Bitmap(e.target.content.bitmapData);
			bitmapdata = new BitmapData(loader.width,loader.height);
			bitmapdata.draw(loader);
			this.width = loader.width;
			this.height = loader.height;
		}
		private function onProgress(e:ProgressEvent):void{
			
		}
		public function getLoader():Loader{
			return this.loader;
		}
		public function getBitmap():Bitmap{
			return this.bitmap;
		}
		public function getBitmaData():BitmapData{
			return this.bitmapdata;
		}
	}
}