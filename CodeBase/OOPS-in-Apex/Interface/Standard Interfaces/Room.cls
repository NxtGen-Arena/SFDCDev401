/**
* Hotel wants to sort Room records dynamically based on room price or capacity.
COmparable interface is Used to sort custom objects or records based on custom logic.
**/
public with sharing class Room implements Comparable 
{
    public Integer roomNumber;
    public Integer roomCapcity;
    public Decimal price;

    public Room(Integer roomNumber, Integer roomCapcity, Decimal price)
    {
        this.roomNumber = roomNumber;
        this.roomCapcity = roomCapcity;
        this.price = price;
    }

    //comparable INterface mehod implementation
    public Integer compareTo(Object compareToObj)
    {
        Room otherRoom = (Room)compareToObj;

        //sort based on the price (ascending order)
        if(this.price == otherRoom.price)
        {
            return 0;
        }
        else if(this.price > otherRoom.price)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }
}

####################################################################
<h2> Anonymous Apex Code<h2> 
####################################################################

List<Room> rooms = new List<Room>{
    new Room(101, 2, 5000),
    new Room(102, 4, 7000),
    new Room(103, 2, 4500)
};

System.debug('Before Sort: ' + rooms);
rooms.sort();
System.debug('After Sort (by price): ' + rooms);
