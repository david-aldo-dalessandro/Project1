//David D'Alessandro
//12/27/21
//Login Page controller

public with sharing class LoginPageController {
    
    @AuraEnabled(cacheable=true)
    public static Contact authenticateLogin(String userName, String password){
        Contact user = [SELECT name FROM Contact WHERE name = :userName LIMIT 1];

        return user;
    }

}
