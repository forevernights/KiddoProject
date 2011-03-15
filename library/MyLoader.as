package library
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class MyLoader
	{
		private var urlRequest:URLRequest;
		private var loader:Loader;
		public var isLoaded:Boolean = false;
		
		private var width:Number;
		private var height:Number;
		private var alpha:Number;
		private var x:Number;
		private var y:Number;
		public function MyLoader(url:String,properties:Object){
			urlRequest = new URLRequest(url);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded)
			loader.load(urlRequest);
			if(properties !=null){
				this.width = properties.width;
				this.height = properties.height;
				if(properties.alpha==null){
					this.alpha = 1;
				}
				else{
					this.alpha = properties.alpha;	
				}			
			}
			else{
				
			}
		}
		private function onLoaded(e:Event):void{
			isLoaded = true;
			loader.width = this.width;
			loader.height = this.height;
			loader.alpha = this.alpha;
		}
		public function getLoader():Loader{
			return loader;
		}
	}
}