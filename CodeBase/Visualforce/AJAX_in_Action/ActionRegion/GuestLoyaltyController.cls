public with sharing class GuestLoyaltyController {

    //Properties
    public String guestName {get;set;}
    public String email {get;set;}
    public Integer pointsToAdd {get;set;}
    public String message {get;set;}

    public Boolean showLoyaltySuccess {get;set;}
    public Boolean loyaltyPanelDisplayed {get;set;}

    //Constructor
    public GuestLoyaltyController() {
        this.showLoyaltySuccess = false;
        this.loyaltyPanelDisplayed = true;
    }

    public void addLoyaltyPoints()
    {
        if(pointsToAdd != null && pointsToAdd > 0)
        {
            message = 'Added ' + pointsToAdd + ' Loyalty Points';
            showLoyaltySuccess = true;
        }
        else {
            message = 'No points to add.Please enter valid number.';
            showLoyaltySuccess = false;
        }
    }

    public void submitAll()
    {
        message = 'Guest Info submitted: ' + guestName + ' ,' + email;
        loyaltyPanelDisplayed = false;  //hide the loyalty panle after submission
    }
}
