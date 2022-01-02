//David D'Alessandro
//12/31/21
//Product Trigger Helper Test

@isTest
public with sharing class ProductTriggerHelperTest {

    //TP_LinkPriceBookEntry
    //Tests that a Pricebook Entry was created when a Product is created
    //will return true if a Pricebook Entry exists for each product
    @isTest 
    public static void TP_LinkPricebookEntry(){
        Test.startTest();
        //testing variables
        Boolean result = false;
        Integer i;
        Integer numProducts = 10;
        String productName;
        string index;
        //create and insert a Standard Pricebook
        Id pricebookId = Test.getStandardPricebookId(); //generate the StandardPB Id since we don't have one in the test org
        Pricebook2 standardPricebook = new Pricebook2(Id = pricebookId);
        update standardPricebook;
        //create a list of Products
        List<Product2> newProducts = new List<Product2>();
        //create a list of Pricebook Entries
        List<PricebookEntry> newPricebookEntries = new List<PricebookEntry>();
        //load the list full of Products
        for(i = 0; i < numProducts; i++){
            index = String.valueOf(i+1);
            productName = 'Product' + index;
            newProducts.add(new Product2(Name = productName));
        }//end for i
        //begin testing
        insert newProducts;
        //select the pricebook entries that should exist now 
        newPricebookEntries = [SELECT id FROM PricebookEntry WHERE isActive = true];
        System.debug('Number of PBEs = ' + newPricebookEntries.size());
        System.debug('Results before: ' + result);
        //check the list is not empty
        if(newPricebookEntries.size() == numProducts){
            result = true;
        }//end if
        System.debug('Result after: ' + result);
        //evaluate the result
        System.assert(result);
        Test.stopTest();
    }//end TP_LinkPricebookEntry

}//end class