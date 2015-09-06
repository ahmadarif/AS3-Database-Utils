# AS3-Database-Utils
Access your local database using Action Script 3.

# Getting started
	- Add AS3-Database-Utils.swc to Your project
	- Let's implement the code below
	
# Create class that represent Table
	public class Person extends Entity
	{
		public var name:String;
		public var age:uint;
		public var mail:String;
	}
	
# Initialize database
	Db.loadDatabase("Person");
	
# Register Entity
	Db.registerEntity(Person); // one Entity
	Db.registerEntitys([Person, Animal]); // many Entity

# Save data
	var person:Person = new Person();
	person.name = "Ahmad Arif";
	person.age = 23;
	person.mail = "ahmad.arif019@gmail.com";
	Db.save(person);
	
# Update data
	var person:Person = new Person();
	person.id = 1;
	person.name = "Arif Ahmad";
	person.age = 100;
	person.mail = "ahmad_arif@icloud.com";
	Db.update(person);
	
# Remove data
	var person:Person = new Person();
	person.id = 1;
	Db.remove(person);
	
# Get all data
	var result:Array = Db.getAll(Person);
	if(result != null)
	{
		for (var i:uint = 0; i < result.length; i++)
		{
			var tmp:Person = result[i];
			trace(tmp.name);
		}
	}
	
# Get data by id
	var obj:Person = Db.getById(Person, 2);
	if(obj != null) 
	{
		trace("Name = " + obj.name);
	}
	
# Get data by object
	var result:Array = Db.getByObject(Person);
	if(result != null)
	{
		for (var i:uint = 0; i < result.length; i++)
		{
			var tmp:Person = result[i];
			trace(tmp.name);
		}
	}