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
        }

        return newAccounts;

    }//end CreateAccountEmpty (Multiple)

   



}
