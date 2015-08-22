package gambite 
{
	import flash.display.Sprite;
	
	import gambite.utils.database.Db;
	import gambite.utils.database.Entity;
	
	public class Package extends Sprite
	{	
		public function Package() 
		{
			var build:Array = [Db, Entity];
		}
	}
	
}
