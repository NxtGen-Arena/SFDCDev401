# Runtime Polymorphism

We’ll build two classes — Animal and Bird

🧩 1️⃣ Upcasting: treating subclass object as its superclass type

~~~Apex Execute Anonymous
Animal birdCategory = new Bird();
birdCategory.displayAnimalInfo();
birdCategory.fly();
~~~
Here’s what happens:

* new Bird() → creates an instance of the Bird class.
* Animal birdCategory → means the reference variable is of type Animal, but it is pointing to a Bird object.
* This is upcasting — treating a subclass object as its superclass type.

👉 Key Point:
When you call methods using a superclass reference that are overridden in the subclass, the subclass version is executed.
This is called runtime polymorphism (or dynamic method dispatch).

🧪 Execution:

~~~
birdCategory.displayAnimalInfo();  // ✅ Runs Bird's version (overridden)
birdCategory.fly();                // ❌ Compilation error
~~~

Why?

* displayAnimalInfo() exists in both Animal and Bird → Bird’s version runs.
* fly() exists only in Bird, but the reference type is Animal, which doesn’t know about fly().
* Therefore, you’ll get a compile-time error:
    Method does not exist or incorrect signature: fly() from the type Animal.

---------------------------------------------------------------------------------
🧩 2️⃣ Direct Reference
~~~ Apex Execute Anonymous
Bird newBird = new Bird();
newBird.displayAnimalInfo();
newBird.fly();
~~~

Here, both the reference type and the object type are Bird.

That means you can access everything inside the Bird class, including its inherited and unique methods.

🧪 Execution:
~~~
newBird.displayAnimalInfo(); // ✅ Runs Bird's version
newBird.fly();               // ✅ Works perfectly
~~~

--------------------------------------------------------------------------------
🧩 2️⃣ Downcasting

~~~ Apex Execute Anonymous
// --- Optional: Downcasting ---
Bird castedBird = (Bird)birdCategory;
castedBird.fly(); // Works after explicit cast
~~~

--------------------------------------------------------------------------------
💡 Key Learning

* Polymorphism → method resolution happens at runtime (Bird’s method runs even when reference is Animal).
* Encapsulation of type → reference type (Animal) defines which methods you can call.
* Inheritance → allows reusing and extending behavior.
  
