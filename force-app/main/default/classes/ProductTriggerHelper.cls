//David D'Alessandro
//12/31/21
//Product Trigger Helper 

public with sharing class ProductTriggerHelper {

    //linkPricebookEntry
    //creates and links pricebook to the product after
    //the product is created
    public static void LinkPricebookEntry(List<Product2> newProducts){

        //variables
        Decimal unitPrice = 100.00;

        //get standard Pricebook id
        Pricebook2 standardPricebook = [SELECT id FROM Pricebook2 WHERE IsStandard = true];

        //create list for PricebookEntries
        List<PricebookEntry> newPricebookEntries = new List<PricebookEntry>();

        //loop over newProducts and assigns Product2 Id and Standard Pricebook Id to new PricebookEntry
        for(Product2 newProduct : newProducts){
            newPricebookEntries.add(new PricebookEntry(Product2Id = newProduct.Id, Pricebook2Id = standardPricebook.Id, UnitPrice = unitPrice, isActive = true));
        }//end newProduct

        //insert the list of new PricebookEntries
        insert newPricebookEntries;

    }//end linkPricebook
 
}//end class