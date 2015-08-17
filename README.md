# AS3-Database-Utils
Access your local database using Action Script 3.

# Getting started

1. Initialize database
	DatabaseUtils.loadDatabase("Person");
	
2. Create class that represent Table
	public class Person extends Entity
	{
		public var name:String;
		public var age:uint;
		public var mail:String;
	}
	
3. Register class/entity
	DatabaseUtils.registerClass(Person);

4. Save data
	var person:Person = new Person();
	person.name = "Ahmad Arif";
	person.age = 23;
	person.mail = "ahmad.arif019@gmail.com";
	DatabaseUtils.save(person);
	
5. Update data
	var person:Person = new Person();
	person.id = 1;
	person.name = "AA";
	person.age = 100;
	person.mail = "aa.com";
	DatabaseUtils.update(person);
	
6. Remove data
	var person:Person = new Person();
	person.id = 1;
	DatabaseUtils.remove(person);
	
7. Get all data
	var result:Array = DatabaseUtils.getAll(Person);
	if(result != null)
	{
		for (var i:uint = 0; i < result.length; i++)
		{
			trace(result[i].name);
		}
	}
	
8. Get data by id
	var obj:Object = DatabaseUtils.getById(Person, 1);
	if(obj != null)
	{
		trace(obj.name);
	}