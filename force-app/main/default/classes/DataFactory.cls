//David D'Alessandro
//12/22/21
//Data factory for all necessary pieces of data

public with sharing class DataFactory {
    
    //----------------Accounts--------------------//
    //-----------Empty Accounts--------------------//
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

    //-----------Filled Accounts--------------------//
    //CreateAccountFilled (Single)
    //creates a single filled account
    public static Account CreateAccountFilled(){
        //create an account
        Account newAccount = new Account(Name = 'Test', Phone = '(666) 666-6666');
        return newAccount;
    }//end CreateAccountFilled (Single)

    //CreateAccountFilled (Multiple)
    //creates multiple uniquely filled accounts
    public static List<Account> CreateAccountFilled(Integer numAccounts){
        String name;
        String phone;
        String index;
        //create an empty list for accounts
        List<Account> newAccounts = new List<Account>();
        //create new accounts for list
        for(Integer i = 0; i < numAccounts; i++){
            index = String.valueOf(i+1);
            name = 'Test' + index;
            phone = '(666) 666 6666'+ index;
            newAccounts.add(new Account(Name = name, Phone = phone));
        }//end for i
        //return results
        return newAccounts;
    }//end CreateAccountFilled (Multiple)

   
    //----------------User_Profiles----------------//

    //----------------Empty Profiles---------------//
    //CreateUser_Profile (Single)
    //creates a single empty user_profile
    public static User_Profile__c CreateUser_ProfileEmpty(){
        User_Profile__c newUser_Profile = new User_Profile__c();

        return newUser_Profile;
    }//end CreateUser_ProfileEmpty (Single)

    //CreateUser_ProfileEmpty (Multiple)
    //creates multiple empty user_profiles
    public static List<User_Profile__c> CreateUser_ProfileEmpty(Integer numUser_Profiles){
        List<User_Profile__c> newUser_Profiles = new List<User_Profile__c>();
        for(Integer i = 0; i < numUser_Profiles; i++){
            newUser_Profiles.add(new User_Profile__c());
        }//end for i
        return newUser_Profiles;
    }//end CreateUser_ProfileEmpty (Multiple)

    //----------------Filled Profiles---------------//
    //CreateUser_ProfileFilled (Single)
    //creates a single filled user_profile
    public static User_Profile__c CreateUser_ProfileFilled(String contactUser){
        User_Profile__c newUser_Profile = new User_Profile__c(Name = 'Test', password__c = 'password', email__c = 'email@email.com', phone__c = ' (666) 666 6666', Contact_User__c = contactUser);
        return newUser_Profile;
    }//end CreatUser_ProfileFilled Single

    //CreateUser_ProfileFilled (multiple)
    //creates multiple filled user_profiles with unique names and emails
    //'different' parameter is for creating another set of objects with names that differ from the first potential set
    public static List<User_Profile__c> CreateUser_ProfileFilled(Integer numUser_Profiles, Boolean different, List<Contact> contactUser){
        List<User_Profile__c> newUser_Profiles = new List<User_Profile__c>();
        String user_Name;
        String email;
        String index;
        if(different){
            for(Integer i = 0; i < numUser_Profiles; i++){
                index = String.valueOf(i+1);
                user_Name = 'Test' + index;
                email = 'email' + index + '@email.com';
                newUser_Profiles.add(new User_Profile__c(Name = user_Name, password__c = 'password', email__c = email, phone__c = ' (666) 666 6666', Contact_User__c = contactUser[i].Id));
            }//end for i
        }//end if different
        else{
            for(Integer i = 0; i < numUser_Profiles; i++){
                index = String.valueOf(i+1+numUser_Profiles);
                user_Name = 'Test' + index;
                email = 'email' + index + '@email.com';
                newUser_Profiles.add(new User_Profile__c(Name = user_Name, password__c = 'password', email__c = email, phone__c = ' (666) 666 6666', Contact_User__c = contactUser[i].Id));
                }//end for i
        }//end else
        return newUser_Profiles;
    }//end CreateUser_ProfileFilled (Multiple)

}