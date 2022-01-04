//David D'Alessandro
//12/27/21
//Login Page controller

@isTest
public with sharing class LoginPageControllerTest {
   
    //Test Positive
    @isTest
    public static void TP_authenticateLogin(){
    Test.startTest();

    //create a contact to relate to a user profile
    Contact newContact = new Contact(firstName='Name', lastName='Last Name');
    insert newContact;

    //create a user_profile record to search
    User_Profile__c newUser = new User_Profile__c(Name = 'Name', Email__c = 'email@email.com', Contact_User__c = newContact.Id, Password__c = 'Password', Phone__c = '(666) 666 6666');

    //insert it into the database
    insert newUser;

    //create a new user profile and set it equal to the function to test
    User_Profile__c returnedUser = LoginPageController.authenticateLogin('Name', 'Password');

    System.assertEquals('Name', returnedUser.Name);
    Test.stopTest();    
    }//end TP_authenticateLogin

    //Test Negative
    @isTest 
    public static void TN_authenticateLogin(){
        Test.startTest();

        //create a contact to relate to a user profile
        Contact newContact = new Contact(firstName='Name', lastName='Last Name');
        insert newContact;

        //create a user_profile record to search
        User_Profile__c newUser = new User_Profile__c(Name = 'Name', Email__c = 'email@email.com', Contact_User__c = newContact.Id, Password__c = 'Password', Phone__c = '(666) 666 6666');

        //insert it into the database
        insert newUser;

        //create a new user profile and set it equal to the function to test with the incorrect name
        User_Profile__c returnedUser = LoginPageController.authenticateLogin('WrongName', 'Password');

        System.assertEquals(null, returnedUser);
        
        Test.stopTest();
    }//end TN_authenticareLogin

    
}//end class
