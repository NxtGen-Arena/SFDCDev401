public with sharing class Cat extends Animal {
    
    //abstrct method from base class is implemented in child class
    public override void makeSound()
    {
        System.debug('Meow...');
    }

    public void playsCall()
    {
        System.debug('Cats are play Call');
    }
}
