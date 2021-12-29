//David D'Alessandro
//12/28/21
//User_Profile Trigger Helper

public with sharing class User_ProfileTiggerHelper {
    public User_ProfileTiggerHelper() {
        system.debug('hello');
    }

    //User_ProfileValidateDuplicate
    //ensure no profile is created with the same name or email
    public static void User_ProfileValidateDuplicate(List<User_Profile__c> newUser_Profiles){
        
        //query for all current user profile names and emails
        List<User_Profile__c> currUser_Profiles = [SELECT Name, email__c FROM User_Profile__c];

        //loop through the new profiles
        for(User_Profile__c newUser_Profile : newUser_Profiles){

        }//end for newUser_Profiles



    }



}
