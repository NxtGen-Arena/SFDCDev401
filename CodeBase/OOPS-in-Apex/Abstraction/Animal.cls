public abstract class Animal {
    public String name {get;set;}

    //abstract method - only definition , body to be implemented by subclas extending this class
    public abstract void makeSound();

    //concrete method - definition and body
    public void move(){
        System.debug('Move method is implemented');
    }
}
