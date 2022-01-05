//David D'Alessandro
//12/26/21
//Product page controller test

@isTest
public with sharing class ProductCarouselControllerTest {

    //Test Positive GetProducts
    @isTest 
    public static void TP_GetProducts(){
        Test.startTest();
        //variables for testing
        Integer numProducts = 10;
        Integer i;
        String currName;
        String index;

        //create a list of products to search for
        List<Product2> currProducts = new List<Product2>();
        //create a list for products to be returned to
        List<Product2> returnedProducts = new List<Product2>();
        //create and insert a Standard Pricebook
        Id pricebookId = Test.getStandardPricebookId(); //generate the StandardPB Id since we don't have one in the test org
        Pricebook2 standardPricebook = new Pricebook2(Id = pricebookId);
        update standardPricebook;
        //load the list with products having individual names
        for(i = 0; i < numProducts; i++){
            index = String.valueOf(i+1);
            currName = 'Test' + index;
            currProducts.add(new Product2(Name = currName));
        }//end for i

        //insert the list
        insert currProducts;

        //test the function
        returnedProducts = ProductCarouselController.GetProducts();
        System.assertEquals(numProducts, returnedProducts.size());

        Test.stopTest();
    }//end TP_GetProducts

    //Test Negative GetProducts
    @isTest 
    public static void TN_GetProducts(){
        Test.startTest();

        //create a list for the products to be returned to
        List<Product2> returnedProducts = new List<Product2>();

        //test the function
        returnedProducts = ProductCarouselController.GetProducts();

        System.assertEquals(null, returnedProducts);

        Test.stopTest();
    }//end TN_GetProducts

    //TP_GetContracts
    @isTest 
    public static void TP_GetContracts(){
        Test.startTest();
        //test variables 
        Integer numRecords = 10;
        Integer i;
        String recordName;
        String index;

        //create account for contracts
        Account currAccount = new Account(Name = 'recordName', Phone = '(666) 666 6666');
        Account idAccount = new Account();

        //insert accounts
        insert currAccount;

        //query for accounts to get Ids
        idAccount = [SELECT Id FROM Account];

        //create contracts 
        List<Contract> currContracts = new List<Contract>();
        List<Contract> returnedContracts = new List<Contract>();

        //load with data
        for(i = 0; i < numRecords; i++){
            currContracts.add(new Contract(StartDate = date.today(), AccountId = idAccount.Id, ContractTerm = 3, Status = 'Draft'));
        }//end i

        //insert Conctracts
        insert currContracts;

        //test the function
        returnedContracts = ProductCarouselController.GetContracts(idAccount.Id);
    
        System.assertEquals(numRecords, returnedContracts.size());

        Test.stopTest();
    }//end TP_GetContracts

    //Test Negative GetContracts
    @isTest 
    public static void TN_GetContracts(){

        //create an account for an id
        Account currAccount = new Account(Name = 'recordName', Phone = '(666) 666 6666');
        Account returnedAccount = new Account();
        //insert the account
        insert currAccount;

        //query for account id
        returnedAccount = [SELECT Id FROM Account];

        //create list for returned contracts
        List<Contract> returnedContracts = new List<Contract>();

        //test the function
        returnedContracts = ProductCarouselController.GetContracts(returnedAccount.Id);

        System.assertEquals(null, returnedContracts);
    }//end TN_GetContracts

    //Test Positive InsertOrder
    @isTest 
    public static void TP_InsertOrder(){
        Test.startTest();
        //teat variables
        Boolean result;
        //create an account
        Account currAccount = new Account(Name = 'Name', Phone = '(666) 666 6666');
        insert currAccount;
        //create a contract using a prebuilt function
        Contract currContract = new Contract(StartDate = date.today(), AccountId = currAccount.Id, ContractTerm = 3, Status = 'Draft');
        System.debug('Contract ID = ' + currContract.Id);
        insert currContract;
        //create the standard pricebook
        Id pricebookId = Test.getStandardPricebookId(); //generate the StandardPB Id since we don't have one in the test org
        Pricebook2 standardPricebook = new Pricebook2(Id = pricebookId);
        update standardPricebook;

        //test the function
        result = ProductCarouselController.InsertOrder(currAccount.Id, currContract.Id);
        System.debug('The result is ' + result);

        System.assertEquals(null, result);

        Test.stopTest();
    }//end TP_InsertOrder

}//end class
