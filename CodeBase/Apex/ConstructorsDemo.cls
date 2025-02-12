/*
 * Author: Sheetal Chougu;e
 * Purpose/Description: Created to demonstrate the oops concepts in Apex
 * Used in: N/A
 Change Log 
 |Author | Date Modified  |Changes Made            | User Story|
 Sheetal | 28th AUg | Class created with variables |
 Sheetal | 28th AUg | Constructor added |
*/
public virtual class Dog {
    
    //Constants: all caps
    //Constants are initialized once in lifecycle
    public static final Integer LEGS = 4;
    public static final Integer EYES = 2;
    
    public Date birthDate { get; set; }

    //Private instance variables - camelCase
    //Variables created - instantiation 
    private String name;
    private Integer age;
    //Variable initialized
    private Boolean isVaccinated = false;
    private Double weight;
    
    //protected : accessible within class and subclass
    protected String breed;
    
    //Default modifier (package-private): Accessible within only same namespace for package
    String color;

    
    //default constructor (No-argument public contrustor) - with no arguments /paramaters
    //constructor always match the names with Class
    //Constructors do not return any value. hence they do not have return type
    public Dog()
    {
        // Using this(...) calls the one argument constructor
        //Call to 'this()' must be the first statement in a constructor method
        this('Tara', 1, false, 'German Shephard', 'Black'); //constructor chaining

        system.debug('Inside default constructor');
    }

    //Parameterized constructor - overloaded
    // BEST PRACTICE: Avoid too many parameters in the methods
    //If you have more than 3-5 parameters, consider creating a new class 
   // and passing an instance of that as argument 
    public Dog(String name, Integer age, Boolean isVaccinated, String breed, String color){
        this.name = name;
        this.age = age;
        this.isVaccinated = isVaccinated;
        this.breed = breed;
         system.debug('Inside param constructor');
    }

    // Constructor - overloading
    public Dog(String name, String breed, Date birthDate) {
        this.name = name;
        this.breed = breed;
        this.birthDate = birthDate;
        this.age = calculateAge();
    }

    // Public method to calculate age as of today based on birthdate
    public Integer calculateAge() {
        Date today = Date.today();
        Integer age = today.year() - birthDate.year();
        if (today < birthDate.addYears(age)) {
            age--;
        }
        this.age = age;
        return age;
    }

    public Integer getAge()
    {
        return this.age;
    }

    // Public method to get the breed (returns data)
    public String getBreed() {
        return this.breed;
    }

    // Public method to set the breed (no return)
    public void setBreed(String breed) {
        this.breed = breed;
    }

     //Method Overloading:Started
     //Creation on methods with same name and different paramters
     //Purpose - handle different type of data or params of inputs 

    // [Mehod 1 - Overloaded - Default - No Param] Public method without parameters (returns data)
    public String bark() {
        return name + ' says Woof!';    // value of name variable concatenated (+) with static string.
    }

    //[Method 2 - Overloaded - parameter] Method with sound as an input paramater
    public String bark(String sound) {
        return name + ' says '+ sound + ' !!';
    }

    //Method Overloading: 2 paramaters Sound and # of times to make the sound
    public String bark(String sound, Integer times) {
        String output = '';
        for (Integer i=1; i<=times; i++) {
            output += name + ' says '+ sound + ' ' + i + ' times !!';
        }
        return output;
    }

    //Method Overloading:ended

    //method oeverriding:Started

    //virtual method makeSound, allowing overiridng in Specific subclass
    public virtual void makeSound() {
        System.debug('Dog is making a sound');
    }

    //method oeverriding:Started

    // Public method without parameters (no return)
    public void birthday() {
        this.age++;                                     // this.age = age + 1;
        System.debug(name + ' is now ' + age + ' years old.');
    }

    // Public method with parameters (returns data)
    //Description: <<purpose of the methods>>
    //Return type: explain the return type
    //Params: explain specific params used
    //AUdit Info:  Added AUdit info here - whtever changes made. 
    //Changes made for: user story reference
    public String getDogInfo(Boolean includeAge) {
    
        if (includeAge) {
            return 'Name: ' + name + ', Breed: ' + breed + ', Age: ' + age + ' years';
        } else {
            return 'Name: ' + name + ', Breed: ' + breed;
        }
    }

    // Static method to compare ages of two dogs
    //static methods cannot be invoked from non-static context
    public static String compareAges(Dog dog1, Dog dog2) {
      // this.getDogInfo(true);
        if (dog1.age > dog2.age) {
            return dog1.name + ' is older than ' + dog2.name;
        } else if (dog1.age < dog2.age) {
            return dog2.name + ' is older than ' + dog1.name;
        } else {
            return dog1.name + ' and ' + dog2.name + ' are of the same age';
        }
    }
}

/*
//Execute Anonymous code
Dog labrador = new Dog('Buddy','Labrador',Date.newInstance(2018,5,10));
system.debug('labrador >> ' + labrador);
system.debug('labrador age>> ' + labrador.age);

Dog beagle = new Dog('Max','Beagle',Date.newInstance(2022,3,3));
Dog bullDog = new Dog('Rocky',1,True,'Bulldog');

//Invoking methods
system.debug(labrador.bark());
system.debug(labrador.getDogInfo(true));
system.debug(beagle.getDogInfo(true));
system.debug(bulldog.getDogInfo(false));

*/
