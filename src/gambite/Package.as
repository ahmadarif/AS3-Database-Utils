package gambite 
{
	import flash.display.Sprite;
	import gambite.utils.DatabaseUtils;
	import gambite.utils.Entity;
	
	public class Package extends Sprite
	{	
		public function Package() {
			var a:Array = [DatabaseUtils, Entity];
		}
	}
	
}
