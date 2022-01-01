//David D'Alessandro
//12/27/21
//Login Page controller

public with sharing class LoginPageController {
    
    @AuraEnabled(cacheable=true)
    public static User_Profile__c authenticateLogin(String userName, String password){
        User_Profile__c user = [SELECT name, email__c, phone__c, Contact_User__r.AccountId FROM User_Profile__c WHERE name = :userName AND password__c = :password];

        return user;
    }

}
