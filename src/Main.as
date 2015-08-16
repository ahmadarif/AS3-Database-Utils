package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
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
			
			var person:Person = new Person();
			person.name = "Ahmad Arif";
			person.age = 23;
			person.mail = "ahmad.arif019@gmail.com";
			DatabaseUtils.save(person);
			
			person.id = 1;
			person.name = "AA";
			person.age = 100;
			person.mail = "aa.com";
			DatabaseUtils.update(person);
			
			DatabaseUtils.remove(person);
		}
		
		private function deactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}