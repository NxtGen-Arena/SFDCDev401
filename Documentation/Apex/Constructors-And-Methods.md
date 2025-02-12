# Constructors and Methods

<h2>Constructors</h2>
A constructor is a special method that is invoked when an object of a class is created. It is used to initialize the object’s state. In Apex, constructors have the same name as the class and do not have a return type. There are two types of constructors: default constructor and parameterized constructor.

You do not need to write a constructor for every class. If a class doesn't have a user-defined constructor, a default, no-argument constructor with the same visibility as the containing class is generated.

>[!Important]
>Construtor has same name as class and never has an explicit return type and it is not inherited by the object created from it.

## Things to note

* If you write a constructor that takes arguments, you can then use that constructor to create an object using those arguments.
* If you create a constructor that takes arguments, and you still want to use a no-argument constructor, you must create your own no-argument constructor in your code. After you create a constructor for a class, you no longer have access to the default, no-argument public constructor.
* In Apex, a constructor can be overloaded, that is, there can be more than one constructor for a class, each having different parameters.
* you must use the _new_ keyword in order to instantiate an object from that class, using that constructor.
* Every constructor created for a class must have a different argument list.

## Default Constructor

If a class does not have any constructors defined, Apex provides a default constructor with no parameters.

## Parameterized Constructor

A parameterized constructor accepts parameters to initialize the object’s state. It allows you to pass values during object creation. 



