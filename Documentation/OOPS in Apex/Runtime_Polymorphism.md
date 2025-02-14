# Runtime Polymorphism in Salesforce

In Apex (and object-oriented programming in general), runtime polymorphism is achieved through method overriding, where a subclass provides a specific implementation of a method that is already defined in its parent class.
This allows for dynamic method dispatch, where the method that gets executed depends on the actual type of the object at runtime, not the compile-time type.
This is very useful when you have multiple subclasses that can share the same interface, but the actual behavior depends on the subclass.

## <b>When to use it: </b>
Use runtime polymorphism when you have a parent class with a method, and subclasses that need to implement their own versions of that method.

You would use runtime polymorphism when you have a common interface or behavior (Dog class in this case) and you want different classes to implement this behavior in a way that's specific to their types. This is very useful when you have multiple subclasses that can share the same interface, but the actual behavior depends on the subclass.

## How it works:
The method in the parent class is declared as virtual (to allow overriding). 
The subclass uses the override keyword to provide a specific implementation. 
When a method is called on a reference of the parent class, the runtime determines which version of the method to invoke based on the actual object type.

![image](https://github.com/user-attachments/assets/d1ce1d02-9695-45c7-b396-b61a51b5d328)


## Benefits of Runtime Polymorphism:

* <b>Flexibility</b>: The code is more flexible and can be extended easily. You can add new subclasses without modifying the parent class.
* <b>Code Reusability:</b> The parent class provides a common interface, while subclasses can reuse and extend functionality.
* <b>Dynamic Method Dispatch:</b> At runtime, the correct method is called based on the actual type of the object, ensuring the right behavior is executed.

## How does @override work?

The @override keyword in Apex is used when a subclass provides a specific implementation of a method that is already defined in its parent class. It is an annotation that indicates that the method in the subclass is meant to override (replace) the method in the parent class.

1. <b>Ensures Correct Method Overriding:</b>
When you use @override, the compiler checks if the subclass method actually overrides a method from the parent class. If the parent class does not have a method with the same name and signature, the Apex compiler will throw an error.
This prevents mistakes where a method is meant to override a parent method but doesn't due to a typo or incorrect method signature.

3. <b>Method Signature:</b>
The method in the subclass must have the same name, return type, and parameters as the method in the parent class that it is overriding. The @override annotation ensures that these match exactly.
If there's a mismatch (e.g., different return type or method name), the compiler will catch this and produce an error.

4. <b>Behavior Override:</b>
The behavior of the overridden method in the parent class is replaced by the new implementation in the subclass.
Even if you call the method using a reference of the parent class, the overridden method in the subclass will execute at runtime (this is the essence of runtime polymorphism).

