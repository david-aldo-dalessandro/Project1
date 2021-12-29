//David D'Alessandro
//12/22/21
//Test class for the account trigger helper class

@isTest
public with sharing class AccountTriggerHelperTest {


    //TP_TestAccountValidateEmpty
    //Tests the AccountValidateEmpty method for a postive insertion
    @isTest 
    public static void TP_TestAccountValidateEmpty(){


    }//end TP_TestAccountValidateEmpty()

    //TN_TestAccountValidateEmpty
    //Tests the AccountValidateEmpty method for a negative insertion
    @isTest 
    public static void TN_TestAccountValidateEmpty(){

        //List of booleans for results of tests
        List<Boolean> result= new List<Boolean>();

        List<Account> testAccounts = DataFactory.CreateAccountEmpty(10);
        List<Account> testAccountsName = new List<Account>();
        List<Account> testAccountsPhone = new List<Account>();

        for(Integer i = 0; i < 10; i++){
            testAccountsName.add(new Account(name = 'testName'));
            testAccountsPhone.add(new Account(phone = '6666666666'));
        }//end for i

        //call the function to test
        result.add(AccountTriggerHelper.AccountValidateEmpty(testAccounts));
        result.add(AccountTriggerHelper.AccountValidateEmpty(testAccountsName));
        result.add(AccountTriggerHelper.AccountValidateEmpty(testAccountsPhone));

        //assert the result
        System.assert(!result[0]); //tests totally empty account
        //System.assert(result[1]); //tests account with only name
        //System.assert(result[2]); //tests account with only phone
        
    }//end TN_TestAccountValidateEmpty

}
