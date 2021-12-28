// David D'Alessandro
// 12/22/21
// Handler class for the Account Trigger

public with sharing class AccountTriggerHelper {

        //AccountValidateEmpty
    //Ensures no entries for name nor phone are left blank
    public static Boolean AccountValidateEmpty(List<Account> newAccounts){

        Boolean result = true;

        for(Account newAccount : newAccounts){
            if(String.isBlank(newAccount.name)){
                newAccount.addError('ERROR: A valid name must be entered');
                result = false;
            }//end if name
            else if(String.isBlank(newAccount.phone)){
                newAccount.addError('ERROR: A valid phone number must be entered');
                //result = false;
            }//end if phone
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
        for(Account newAccount : newAccounts){
            for(Account currAccount : currAccounts){
                if(newAccount.name == currAccount.name){
                    newAccount.addError('ERROR: name has already been used');
                }//end if name
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
