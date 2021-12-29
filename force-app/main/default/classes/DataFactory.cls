//David D'Alessandro
//12/22/21
//Data factory for all necessary pieces of data

public with sharing class DataFactory {
    
    //----------------Accounts--------------------//
     //CreateAccountEmpty (Single)
     //creates a single empty account
     public static Account CreateAccountEmpty(){

        Account newAccount = new Account();

        return newAccount;

    }//end CreateAccountEmpty (Single)
    
    //CreateAccountEmpty (Multiple)
    //creates multiple empty accounts
    public static List<Account> CreateAccountEmpty(Integer numAccounts){

        List<Account> newAccounts = new List<Account>();

        for(Integer i = 0; i < numAccounts; i++){
            newAccounts.add(new Account());
        }//end for i

        return newAccounts;

    }//end CreateAccountEmpty (Multiple)

   
    //----------------User_Profiles----------------//

    //----------------Empty Profiles---------------//
    //CreateUser_Profile (Single)
    //creates a single empty user_profile
    public static User_Profile__c CreateUser_ProfileEmpty(){
        User_Profile__c newUser_Profile = new User_Profile__c();

        return newUser_Profile;
    }// CreateUser_ProfileEmpty

    //CreateUser_ProfileEmpty (Multiple)
    //creates multiple empty user_profiles
    public static List<User_Profile__c> CreateUser_ProfileEmpty(Integer numUser_Profiles){
        
        List<User_Profile__c> newUser_Profiles = new List<User_Profile__c>();

        for(Integer i = 0; i < numUser_Profiles; i++){
            newUser_Profiles.add(new User_Profile__c());
        }//end for i

        return newUser_Profiles;
    }

    //----------------Filled Profiles---------------//
    //CreateUser_ProfileFilled (single)
    //creates a single filled user_profile
    public static User_Profile__c CreateUser_ProfileFilled(){
        User_Profile__c newUser_Profile = new User_Profile__c(Name = 'Test', password__c = 'password', email__c = 'email@email.com', phone__c = ' (666) 666 6666');

        return newUser_Profile;
    }

    //CreateUser_ProfileFilled (multiple)
    //creates multiple filled user_profiles with unique names
    public static List<User_Profile__c> CreateUser_ProfileFilled(Integer numUser_Profiles){

        List<User_Profile__c> newUser_Profiles = new List<User_Profile__c>();
        String user_Name = '';
        String test = 'Test';
        String index = '';

        for(Integer i = 0; i < numUser_Profiles; i++){
            index = String.valueOf(i+1);
            user_Name = test + index;
            newUser_Profiles.add(new User_Profile__c(Name = user_Name, password__c = 'password', email__c = 'email@email.com', phone__c = ' (666) 666 6666'));
        }//end for i

        return newUser_Profiles;

    }

}
