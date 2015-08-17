package gambite.utils {
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
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
		
		/**
		 * Fungsi ini harus dipanggil pertama kali sebelum melakukan operasi CRUD dan SELECT
		 * @param	dbName nama database yang akan diload atau dibuat
		 */
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
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
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
			for each (var a:XML in desc.variable) if(a.@name != "id") query += a.@name + " " + a.@type + ", ";
			query = query.substring(0, query.length-2);
			query += ")";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.execute();
		}
		
		/**
		 * Menyimpan/menambahkan entitas ke dalam database
		 * @param	obj entitas yang akan ditambahkan
		 */
		public static function save(obj:Entity):void
		{
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
			var desc:XML;
			var query:String;
			var state:SQLStatement;
			
			desc = describeType(obj);
			
			query = "";
			query += "INSERT INTO " + desc.@name +"(";
			for each (var a:XML in desc.variable) if (a.@name != "id")query += a.@name + ", ";
			query = query.substring(0, query.length - 2);
			query += ") VALUES(";
			for each (a in desc.variable) if (a.@name != "id") query += "'" + obj[a.@name] + "', ";
			query = query.substring(0, query.length - 2);
			query += ")";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void { trace("Save successfully!") } );
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void { trace(e.error.message) } );
			state.execute();
		}
		
		/**
		 * Memperbaharui entitas sesuai dengan id pada entitas tersebut, id tidak dapat diganti
		 * @param	obj entitas yang akan diperbaharui
		 */
		public static function update(obj:Entity):void
		{
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
			var desc:XML;
			var query:String;
			var state:SQLStatement;
			
			desc = describeType(obj);
			
			query = "";
			query += "UPDATE " + desc.@name +" SET ";
			for each (var a:XML in desc.variable) if (a.@name != "id") query += a.@name +"='" + obj[a.@name] + "', ";
			query = query.substring(0, query.length - 2);
			query += " WHERE id='" +obj.id +"'";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void { trace("Update successfully!") } );
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void { trace(e.error.message) } );
			state.execute();
		}
		
		/**
		 * Menghapus data pada database sesuai dengan entitas yang dilewatkan ke dalam parameter
		 * @param	obj entitas yang akan dihapus
		 */
		public static function remove(obj:Entity):void
		{
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
			var desc:XML;
			var query:String;
			var state:SQLStatement;
			
			desc = describeType(obj);
			
			query = "DELETE FROM " + desc.@name + " WHERE id='" + obj.id + "'";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void { trace("Remove successfully!") } );
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void { trace(e.error.message) } );
			state.execute();
		}
		
		/**
		 * Mengirim semua data yang terdapat pada tabel sesuai entitasnya
		 * @param	obj nama entitas yang dimapping dengan tabel
		 * @return mengirim semua entitas yang disimpan ke dalam array, mengirim null jika tidak ada data
		 */
		public static function getAll(obj:Class):Array
		{
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
			var result:Array;
			var query:String;
			var className:String;
			var state:SQLStatement;
			
			className = getQualifiedClassName(obj);
			className.slice(className.lastIndexOf("::") + 2);
			
			query = "SELECT * FROM " + className + " ORDER BY id";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void
			{
				var sqlResult:SQLResult = state.getResult();
				if (sqlResult.data != null)
				{
					result = new Array();
					for (var i:uint = 0; i < sqlResult.data.length; i++)
					{
						result.push(sqlResult.data[i]);
					}
				}
			});
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void { trace(e.error.message); } );
			state.execute();
		
			return result;
		}
		
		/**
		 * Mengirim isi data sesuai dengan entitas dan id yang dilewatkan ke dalam parameter
		 * @param	obj nama entitas yang dimapping dengan tabel
		 * @param	id id entitas
		 * @return mengirim data entitas sesuai dengan id yang dilewatkan ke dalam parameter, mengirim null jika tidak ada data yang dicari
		 */
		public static function getById(obj:Class, id:int):Object
		{
			if (!hasInstance) throw new Error("Error : Panggil fungsi loadDatabase terlebih dahulu!");
			
			var query:String;
			var result:Object;
			var className:String;
			var state:SQLStatement;
			
			className = getQualifiedClassName(obj);
			className.slice(className.lastIndexOf("::") + 2);
			
			query = "SELECT * FROM " + className + " WHERE id='" + id + "'";
			
			state = new SQLStatement();
			state.sqlConnection = conn;
			state.text = query;
			state.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void
			{
				var sqlResult:SQLResult = state.getResult();
				if(sqlResult.data != null) result = sqlResult.data[0];
			});
			state.addEventListener(SQLErrorEvent.ERROR, function(e:SQLErrorEvent):void { trace(e.error.message); } );
			state.execute();
			
			return result;
		}
		
	}
}