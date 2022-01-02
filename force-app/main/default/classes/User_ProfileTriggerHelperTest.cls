//David D'Alessandro
//12/28/21
//User_Profile Trigger Helper Test

@isTest
public with sharing class User_ProfileTriggerHelperTest {

    //TP_User_ProfileValidateDuplicate
    //Test the User_ProfileValidateDuplicare for a true result
    @isTest
    public static void TP_User_ProfileValidateDuplicate(){
        Test.startTest();
        //create variables for results
        Boolean results = false;
        Integer numUser_Profiles = 10;
        //generate profiles for mock database data
        List<User_Profile__c> testMockUser_Profiles = DataFactory.CreateUser_ProfileFilled(numUser_Profiles, false);
        //insert mock data
        insert testMockUser_Profiles;
        //generate profiles for comparison (these will be different from the mock profiles)
        List<User_Profile__c> testUser_Profiles = DataFactory.CreateUser_ProfileFilled(numUser_Profiles, true);
        //begin testing
        results = User_ProfileTriggerHelper.User_ProfileValidateDuplicate(testUser_Profiles);
        //evaluate results
        System.assert(results);
        Test.stopTest();
    }//end TP_User_ProfileValidateDuplicate

    //TN_User_ProfileValidateDuplicate
    //Test the User_ProfileValidateDuplicate for a false result
    @isTest
    public static void TN_User_ProfileValidateDuplicate(){
        Test.startTest();
        //create list for results
        Boolean results = false;
        Integer numUser_Profiles = 10;
        //generate profiles for mock database data
        List<User_Profile__c> testMockUser_Profiles = DataFactory.CreateUser_ProfileFilled(numUser_Profiles, false);
        //insert mock data
        insert testMockUser_Profiles;
        //generate profiles for comparison
        List<User_Profile__c> testUser_Profiles = DataFactory.CreateUser_ProfileFilled(numUser_Profiles, false);
        //begin testing
        results = User_ProfileTriggerHelper.User_ProfileValidateDuplicate(testUser_Profiles);
        //evaluate result
        System.assertEquals(false, results);
        Test.stopTest();
    }//end TN_User_ProfileValidateDuplicate



    //TS

    //TB

    //TR (Test Restricted User)


    
}//end class