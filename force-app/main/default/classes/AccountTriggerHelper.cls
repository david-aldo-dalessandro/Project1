// David D'Alessandro
// 12/22/21
// Handler class for the Account Trigger

public with sharing class AccountTriggerHelper {

    //AccountValidateEmpty
    //ensures no entries for name nor phone are left blank
    //returns false, when account is empty
    public static Boolean AccountValidateEmpty(List<Account> newAccounts){
        //create variable to store result
        Boolean result = true;
        //loop through new accounts
        for(Account newAccount : newAccounts){
            //check account name
            if(String.isBlank(newAccount.name)){
                newAccount.addError('ERROR: A valid name must be entered');
                System.debug('ERROR: A valid name must be entered');
                result = false;
            }//end if name
            //check account phone
            else if(String.isBlank(newAccount.phone)){
                newAccount.addError('ERROR: A valid phone number must be entered');
                System.debug('ERROR: A valid phone number must be entered');
                result = false;
            }//end if phone
            else{
                System.debug('Account passes empty validation');
            }
        }//end for newAccounts
        return result;
    }//end of AccountValidateEmpty
    
    //AccountValidateDuplicate
    //Ensures no new account has the same name nor phone
    //field as an existing account
    public static void AccountValidateDuplicate(List<Account> newAccounts){
        //list of current Accounts in the database
        List<Account> currAccounts = [SELECT name, phone FROM Account];
        //check for duplicate entries of name/email/phone
        //loop through new accounts
        for(Account newAccount : newAccounts){
            //loop through current accounts
            for(Account currAccount : currAccounts){
                //check new account name
                if(newAccount.name == currAccount.name){
                    newAccount.addError('ERROR: name has already been used');
                }//end if name
                //check new account phone
                else if(newAccount.phone == currAccount.phone){
                    newAccount.addError('ERROR: phone has already been used');
                }//end if phone
                else{
                    System.debug('Account passes duplicate validation');
                }//end else
            }//end for currAccounts
        }//end for newAccounts
    }//end AccountValidateDuplicate

}//end class