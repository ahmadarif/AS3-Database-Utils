package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import gambite.utils.DatabaseUtils;
	
	/**
	 * ...
	 * @author Ahmad Arif
	 * @mail ahmad.arif019@gmail.com
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
		
			DatabaseUtils.loadDatabase("Person");
			DatabaseUtils.registerClass(Person);
		}
		
		private function deactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}