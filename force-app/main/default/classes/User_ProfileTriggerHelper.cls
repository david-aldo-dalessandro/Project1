//David D'Alessandro
//12/28/21
//User_Profile Trigger Helper

public with sharing class User_ProfileTriggerHelper {
    public User_ProfileTriggerHelper() {
        system.debug('hello');
    }

    //User_ProfileValidateDuplicate
    //ensure no profile is created with the same name or email
    //returns false is a duplicate exists
    public static Boolean User_ProfileValidateDuplicate(List<User_Profile__c> newUser_Profiles){
        //return variables
        Boolean result = true;

        //query for all current user profile names and emails
        List<User_Profile__c> currUser_Profiles = [SELECT Name, email__c FROM User_Profile__c];

        //loop through the new profiles
        for(User_Profile__c newUser_Profile : newUser_Profiles){
            //loop through the current profiles
            for(User_Profile__c currUser_Profile : currUser_Profiles){
                //compare the name and email values
                System.debug('Currently comparing ' + newUser_Profile.Name + ' to ' + currUser_Profile.Name);
                if(newUser_Profile.Name == currUser_Profile.Name){
                    newUser_Profile.addError('ERROR: Name is already in use');
                    System.debug('user name ' + newUser_Profile.Name + ' already in use');
                    result = false;
                }//end if name
                else if(newUser_Profile.email__c == currUser_Profile.email__c){
                    newUser_Profile.addError('ERROR: Email is already in use');
                    System.debug('email ' + newUser_Profile.email__c + ' already in use');
                    result = false;
                }//end if email 
                else{
                    System.debug('User_Profile passes duplicate validation');
                }// end else
            }//end for currUser_Profiles
        }//end for newUser_Profiles
        System.debug('Returning value of ' + result);
        return result;
    }// end User_ProfileValidateDuplicate



}//end class
