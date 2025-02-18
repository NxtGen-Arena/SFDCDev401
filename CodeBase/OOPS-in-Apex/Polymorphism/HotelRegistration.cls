/**
 * @Description: Method overloading - Compile Time polymorphism. Method signature differs based on - # of Parameters, Type of Parameters
 */
public virtual class HotelRegistration {

    //Default discount no paramters
    public virtual Decimal calculateDiscount() {
        system.debug('default discount: 5% discount');
        return 5.0;
    }

    public Decimal calculateDiscount(Integer age,String membershipLevel,Integer yearsOfLoyalty) {
        Decimal discount = 10.0;
        discount = calculateDiscount(age);
        if(membershipLevel != null && yearsOfLoyalty > 0){
            discount += calculateDiscount(membershipLevel,yearsOfLoyalty);
        }
         system.debug(' discount based on Age and memebrship: 5% discount');
        return discount;
    }

    //Discount for regular customers
    public Decimal calculateDiscount(String customerType) {
        if(customerType == 'Regular'){
             system.debug('default discount for Reguar Customers: 10% discount');
            return 10.0;
        } else {
            return calculateDiscount();
        }   
    }

    //Discounts for Senior Citizens
    public Decimal calculateDiscount(Integer age) {

        if(age >= 65){
             system.debug('default discount for Senior Citizen Customers: 15% discount');
            return 15.0;
        } else {
            return calculateDiscount();
        }
    }

    //Disounts based on membership level
    public Decimal calculateDiscount(String membershipLevel,Integer yearsOfLoyalty)
    {
       Decimal discount = 10.0;
        if(membershipLevel == 'Platinum'){
            discount =  30.0;
        }else if(membershipLevel == 'Gold'){
            discount =  20.0;
        } else if(membershipLevel == 'Silver'){
            discount =  15.0;
        }else if(membershipLevel == 'Bronze'){
            discount =  10.0;
        }

        system.debug('default discount for membershipLevel level: '+ membershipLevel+' discount: '+discount+'%');
        //addional loyalty disocunt (1% per year of loyalty)
        discount += Math.min(yearsOfLoyalty,5);
        system.debug('default discount for yearsOfLoyalty : '+ yearsOfLoyalty+' discount: '+discount+'%');
        return discount;
    }

    //Discounts for Corporate bookings
    public virtual Decimal calculateDiscount(Integer roomsReserved, Boolean isCorporate)
    {
        Decimal corporateDiscount = 10.0;
        if(isCorporate){
            corporateDiscount = roomsReserved * 1.5;  //addiotnal 1.5% per room reserved
            corporateDiscount = Math.min(corporateDiscount, 25.0); // no discount above 25%
        }
        else{
            corporateDiscount = calculateDiscount();
        }
         system.debug(' corporateDiscount : '+ corporateDiscount+'%');
        return corporateDiscount;
    }
}
