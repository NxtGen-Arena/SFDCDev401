# Apex Properties

An Apex property is similar to a variable; however, you can do additional things in your code to a property value before it’s accessed or returned. Properties can be used to validate data before a change is made, to prompt an action when data is changed (such as altering the value of other member variables), or to expose data that is retrieved from some other source (such as another class).

Property definitions include one or two code blocks, representing a get accessor and a set accessor:

1. The code in a get accessor executes when the property is read.
2. The code in a set accessor executes when the property is assigned a new value.
3. If a property has only a get accessor, it’s considered read-only. If a property has only a set accessor, it’s considered write-only.
4. A property with both accessors is considered read-write.

### A few things to note about using apex getters and setters.

* The get accessor must end with a return statement
* The set accessor works similarly to a method with a void return type
* Get and Set accessor cannot be defined on interface
* When you assign a value to a property, the set accessor is invoke with an argument that provides the new value
* Recommended that the get accessor does not change the state of the object that it is defined on

<h2>Different Types of Properties</h2>

### Automatic Properties

When using apex getters and setters, additional code is not required. You can use Automatic properties. With automatic properties it allows you to write more compact code.

```
public String hotelName {get;set;}  //automatic property - read-write
public Integer noOfNights {get;}  //Read only property
public Integer noOfGuests {set;} //Write only property
```

### Traditional Properties
```
public String getHotelName(){
        return hotelName;
    }
    public void setHotelName(String hotelName){
        this.hotelName = hotelName;
    }
```

### Custom Getter and Setters

```
//custom getter to validate the data
    public String getEmail(){Tra
        if(email == null)
            return 'Email not provided';
        return email;
    }

    //Custom setter to valiate the data
    //setter method to modify the customer name
    public void setCustomerName(String customerName){
        if(customerName != null && customerName.length() > 0)
            this.customerName = customerName;
        else 
            System.debug('customerName is Invalid');
    }
```

### Expression Body geter and setter

```
//expression body getter and setter - computed and concise
   public Integer StayDuration {
        get {return stayDuration;}
        set {
            if(value <=0){
                throw new IllegalArgumentException('Stay Duraiton must be postive');
            }
            stayDuration = value;
        }
   }
```

### Lazy loading

```

   // Lazy Loading getter (computed property)
   //This computes the total cost only when it ti accessed, optimizing perfromance
   public Decima getTotalCost(){
        if(totalCost == null && stayDuration != null && roomPrice != null){}
            totalCost = stayDuration * roomPrice;
         }
        return totalCost;
   }
```
