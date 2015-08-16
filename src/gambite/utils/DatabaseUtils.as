package gambite.utils {
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Ahmad Arif
	 * @mail ahmad.arif019@gmail.com
	 */
	public class DatabaseUtils 
	{
		private static var hasInstance:Boolean = false;	
		private static var conn:SQLConnection;
		
		public static function loadDatabase(dbName:String = "myDatabase"):void
		{
			if (!hasInstance)
			{
				hasInstance = true;
				
				conn = new SQLConnection();
				conn.addEventListener(SQLEvent.OPEN, function(e:SQLEvent):void {
					trace("Succes open");
				});
				conn.open(File.applicationDirectory.resolvePath(dbName + ".db"));
			}
		}
		
		/**
		 * Membuat tabel baru jika belum ada
		 * @param	obj variabel untuk tabel yang akan dibuat
		 */
		public static function registerClass(obj:Class):void
		{
			var desc:XML;
			var className:String;
			var query:String;
			var state:SQLStatement;
			
			desc = describeType(new obj());
			
			className = getQualifiedClassName(obj);
			className.slice(className.lastIndexOf("::") + 2);
			
			query = "";
			query += "CREATE TABLE IF NOT EXISTS " +className + " (";
			query += "id INTEGER PRIMARY KEY AUTOINCREMENT, ";
			for each (var a:XML in desc.variable) query += a.@name + " " + a.@type + ", ";
			query = query.substring(0, query.length-2);
			query += ")";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.execute();
		}
		
		public static function save(obj:Object):void
		{
			var desc:XML;
			var query:String;
			var state:SQLStatement;
			
			desc = describeType(obj);
			
			query = "";
			query += "INSERT INTO " + desc.@name +"(";
			for each (var a:XML in desc.variable) query += a.@name + ", ";
			query = query.substring(0, query.length - 2);
			query += ") VALUES(";
			for each (var a:XML in desc.variable) query += "'" + obj[a.@name] + "', ";
			query = query.substring(0, query.length - 2);
			query += ")";
			
			trace(query);
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void
			{
				trace("Berhasil");
			});
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void
			{
				trace("Gagal");
			});
			state.execute();
		}
		
	}
}