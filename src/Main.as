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
	import gambite.utils.Entity;
	
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
			//DatabaseUtils.save(person);
			
			person.id = 1;
			person.name = "AA";
			person.age = 100;
			person.mail = "aa.com";
			//DatabaseUtils.update(person);
			
			//DatabaseUtils.remove(person);
			
			var result:Array = DatabaseUtils.getAll(Person);
			for (var i:uint = 0; i < result.length; i++)
			{
				trace(result[i].name);
			}
			
			trace("\nGet By Id");
			var obj:Object = DatabaseUtils.getById(Person, 1);
			trace("Name = " + obj.name);
		}
		
		private function deactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}