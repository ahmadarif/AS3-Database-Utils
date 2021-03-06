﻿package  
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
	import gambite.utils.database.Db;
	import gambite.utils.database.Entity;
	
	import data.Person;
	
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
		
			trace("Configuration");
			Db.loadDatabase("MyDatabase");
			Db.registerEntitys([Person, Animal]);
			
			trace("   ");
			trace("Save");
			var person:Person = new Person();
			person.name = "Ahmad Arif";
			person.age = 23;
			person.mail = "ahmad.arif019@gmail.com";
			Db.save(person);
			
			trace("   ");
			trace("Update");
			var person:Person = new Person();
			person.id = 1;
			person.name = "Arif Ahmad";
			person.age = 17;
			person.mail = "ahmad_arif@icloud.com";
			Db.update(person);
			
			trace("   ");
			trace("Remove");
			var person:Person = new Person();
			person.id = 1;
			Db.remove(person);
			
			trace("   ");
			trace("Get All");
			var result:Array = Db.getAll(Person);
			if(result != null)
			{
				for (var i:uint = 0; i < result.length; i++)
				{
					var tmp:Person = result[i];
					trace(tmp.name);
				}
			}	
			
			trace("   ");
			trace("\nGet By Id");
			var obj:Person = Db.getById(Person, 2);
			if (obj != null) trace("Name = " + obj.name);
			
			var tes:Person = new Person();
			tes.name = "Ahmad Arif";
			result = Db.getByObject(Person, tes);
			if(result != null)
			{
				for (var i:uint = 0; i < result.length; i++)
				{
					var tmp:Person = result[i];
					trace(tmp.name);
				}
			}	
		}
		
		private function deactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}