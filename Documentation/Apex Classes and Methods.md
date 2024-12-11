# Apex Class

1. Top-level Classes - Frmeowrk and contains main logic 
2. Inner Classes - Class defined within a class

Class contains - Variables, Methods, Constructors

[private | public | global] [virtual | abstract | with sharing | without sharing] class ClassName [implements Interface] [extends ClassName]
{
  //body of the class
}

private - locally. inner classes are always private
public - visible in ur application or namespace
global - all apex code

with / without sharing - defines sharing mode for apex class

virtual - this class allows extensions and overrides.

abstract - contains abstrct methods. Signature declared and no body defined in class

Interface - class implements interfaces and it can be multiple. but can only extend one class. This restricts - Multiple Inheritance

## Variables
[public | private | protected | global] [final] [static] data_type variable_name = [= value or expression]
