//David D'Alessandro
//12/22/21
//Test class for the account trigger helper class

@isTest
public with sharing class AccountTriggerHelperTest {


    //TP_TestAccountValidateEmpty
    //Tests the AccountValidateEmpty method for an accepted account
    @isTest 
    public static void TP_TestAccountValidateEmpty(){
        Test.startTest();
        //List of booleans for results of test
        Boolean result;
        Integer numAccounts = 10;

        //generate accounts for comparison
        List<Account> newAccounts = DataFactory.CreateAccountFilled(numAccounts);

        //begin testing
        result = AccountTriggerHelper.AccountValidateEmpty(newAccounts);

        //evaluate result
        System.assert(result);

        Test.stopTest();
    }//end TP_TestAccountValidateEmpty()

    //TN_TestAccountValidateEmpty
    //Tests the AccountValidateEmpty method for a rejected account
    @isTest 
    public static void TN_TestAccountValidateEmpty(){

        //List of booleans for results of tests
        List<Boolean> results= new List<Boolean>();
        Integer i, j, k;
        Integer numAccounts = 10;
        Integer numTests = 3;

        //create accounts with different fields filled, but not all fields
        List<Account> testAccounts = DataFactory.CreateAccountEmpty(numAccounts);
        List<Account> testAccountsName = new List<Account>();
        List<Account> testAccountsPhone = new List<Account>();

        for(i = 0; i < numAccounts; i++){
            testAccountsName.add(new Account(name = 'testName'));
            testAccountsPhone.add(new Account(phone = '6666666666'));
        }//end for i

        //test methods
        results.add(AccountTriggerHelper.AccountValidateEmpty(testAccounts)); //empty accounts
        results.add(AccountTriggerHelper.AccountValidateEmpty(testAccountsName)); //name only
        results.add(AccountTriggerHelper.AccountValidateEmpty(testAccountsPhone)); //phone only

        //loop through results 
        for(i = 0; i < numTests; i++){
            System.assert(!results[i]);
        }//end for i
        
    }//end TN_TestAccountValidateEmpty



}//end class
