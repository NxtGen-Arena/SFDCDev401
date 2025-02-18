public with sharing class CorporateRegistration extends HotelRegistration {
    
    public override Decimal calculateDiscount(Integer roomsReserved, Boolean isCorporate)
    {
        Decimal corporateDiscount = 15.0;
        if(isCorporate && roomsReserved > 10){
            corporateDiscount = roomsReserved * 2;  //addiotnal 1.5% per room reserved
            corporateDiscount = Math.min(corporateDiscount, 30.0); // no discount above 25%
        }
        else{
            corporateDiscount = super.calculateDiscount(roomsReserved, isCorporate);
        }
         system.debug(' corporateDiscount : '+ corporateDiscount+'%');
        return corporateDiscount;
    }
}
