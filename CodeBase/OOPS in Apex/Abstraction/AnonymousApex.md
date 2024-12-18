Animal myKitty = new Cat();
myKitty.Name = 'Murphy';
myKitty.makeSound();
myKitty.move();
System.debug('Kitty name is ' + myKitty.name);

//output
//|DEBUG|Meow...
//|DEBUG|Move method is implemented
//|DEBUG|Kitty name is Murphy

Cat myKitty = new Cat();
myKitty.Name = 'Murphy';
myKitty.makeSound();
myKitty.move();
myKitty.playsCall();
System.debug('Kitty name is ' + myKitty.name);
//output
//|DEBUG|Meow...
//|DEBUG|Move method is implemented
//|DEBUG|Cats are play Call
//|DEBUG|Kitty name is Murphy
