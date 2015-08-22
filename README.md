# AS3-Database-Utils
Access your local database using Action Script 3.

# Getting started
	- Add AS3-Database-Utils.swc to Your project
	- Let's implement the code below

# Initialize database
	DatabaseUtils.loadDatabase("Person");
	
# Register Entity
	DatabaseUtils.registerEntity(Person); // one Entity
	DatabaseUtils.registerEntitys([Person, Animal]); // many Entity
	
# Create class that represent Table
	public class Person extends Entity
	{
		public var name:String;
		public var age:uint;
		public var mail:String;
	}

# Save data
	var person:Person = new Person();
	person.name = "Ahmad Arif";
	person.age = 23;
	person.mail = "ahmad.arif019@gmail.com";
	DatabaseUtils.save(person);
	
# Update data
	var person:Person = new Person();
	person.id = 1;
	person.name = "Arif Ahmad";
	person.age = 100;
	person.mail = "ahmad_arif@icloud.com";
	DatabaseUtils.update(person);
	
# Remove data
	var person:Person = new Person();
	person.id = 1;
	DatabaseUtils.remove(person);
	
# Get all data
	var result:Array = DatabaseUtils.getAll(Person);
	if(result != null)
	{
		for (var i:uint = 0; i < result.length; i++)
		{
			var tmp:Person = result[i];
			trace(tmp.name);
		}
	}
	
# Get data by id
	var obj:Person = DatabaseUtils.getById(Person, 2);
	if(obj != null) 
	{
		trace("Name = " + obj.name);
	}