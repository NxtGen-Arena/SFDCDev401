public with sharing class RegularCustomerRegistration extends HotelRegistration{

    public override Decimal calculateDiscount(){
        Decimal discount = 0;
         system.debug('default discount: 5% discount');
        return 12.0;
    }
}
