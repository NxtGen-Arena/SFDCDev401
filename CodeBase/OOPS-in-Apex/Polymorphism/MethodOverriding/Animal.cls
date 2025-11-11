/**
 * @Desription: Base Class to demonstate Polymorphism through method overriding
 */
public virtual class Animal 
{
    public string animalType = 'Cat';
    public Animal() 
    {
        system.debug('I am inside Animal Class default Constructor with animal >>>>>>'+ animalType);
    }

    public Animal(string animalType) 
    {
        this.animalType = animalType;
        system.debug('I am inside Animal Class Constructor>>>>>>'+ animalType);
    }

    public  virtual void displayAnimalInfo() 
    {
        system.debug('I am inside Animal Class Method and the Animal Type is:>>>>>>> ' + animalType);
        system.debug('Meow! Meow!>>>>>>');
    }

    public void animalColor(string animalColor) 
    {
        system.debug('I am inside Animal Class Method and the Animal Color is:>>>>>>> ' + animalColor);
    }
}
