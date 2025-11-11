/**
 * @Desription: Class to demonstate Polymorphism through method overriding
 */
public with sharing class Bird extends Animal
{
    public Bird() 
    {
        super();
        system.debug('I am inside bird class>>>>>>');
    }

    //Method defined with virtual keyworf in base class Animal.
    // To override the method, keep the method signature same, declare the method with override keyword
    public override void displayAnimalInfo()
    {
        system.debug('I am inside Bird class method>>>>>>');
        //invokes the base class method
        super.displayAnimalInfo();
    }

    //Error: @Override specified for non-overriding method: void Bird.displayAnimalInfo(Integer)
    //Override allows implementation to be different but the method signature must be same
    /**public override void displayAnimalInfo(Integer iCount)
    {
        system.debug('I am inside Bird class method>>>>>>'+iCount);
    }*/

    //Method defined only in subclass, not in base class
    public void fly()
    {
        system.debug('I am flying>>>>>>');
    }
}
