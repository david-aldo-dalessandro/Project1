//David D'Alessandro
//12/26/21
//Product page controller

public with sharing class ProductCarouselController {
    

    //GetProducts
    //returns a list of current products in the database
    @AuraEnabled(cacheable=true)
    public static List<Product2> GetProducts(){
        //list to store products
        List<Product2> currProducts = new List<Product2>();
        //SOQL query for the products
        currProducts = [SELECT name, description FROM Product2];
        //return statement
        if(currProducts.size() > 0){
            return currProducts;
        }//end if
        else{
            return null;
        }//end else
    }//end GetProducts

    //GetContracts
    //Returns contracts that match an accountId passed into it
    @AuraEnabled(cacheable=true)
    public static List<Contract> GetContracts(String accountId){
        //list to store contracts
        List<Contract> currContracts = new List<Contract>();
        //SOQLquery for the contracts matching the accountId
        currContracts = [SELECT Id, ContractNumber FROM Contract WHERE AccountId = :accountId];
        //return statement
        if(currContracts.size() > 0){
            return currContracts;
        }//end if
        else{
            return null;
        }
    }//end getContracts

    //InsertOrder
    //Inserts an order created from an accountId and contractId passed into it
    //Also queries for Standard pricebook Id
    //returns query for order items
    @AuraEnabled
    public static Boolean InsertOrder(String accountId, String contractId){
        //testing variables
        BOolean result;
        //create a pricebook2 object
        //SOQL query for the standard pricebook
        Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true];
        //create the new oder object
        Order newOrder = new Order(AccountId = accountId, ContractId = contractId, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id = standardPricebook.Id);
        //try the insertion
        if(newOrder != null){
            insert newOrder;
            result = true;
        }
        else{
            result = false;
        }
        return result;
    }//end InsertOrder

    @AuraEnabled
    //CreateOrderItems
    //Creates oderItems for the newly created order using productIds, their quantities, the total number of products, and the accountId associated with the order
    //Also queries for the specific pricebookId related to the order, and all current pricebookEntries 
    public static Boolean CreateOrderItems(List<String> product2Ids, List<Integer> pQuantity, Integer totalItems, String accountId){
        //Testing variables 
        Boolean testResult;
        //creates an order object and queries for the order matching the accountId
        //also ensure that the order it is pulling is empty, validating the current total amount is 0
        Order currOrder = [SELECT Id, Pricebook2Id FROM Order WHERE AccountId = :accountId AND TotalAmount = 0];
        //sets a variable equal to the current pricebook of the order
        String pricebook2Id = currOrder.Pricebook2Id;
        //creates a list for new order itesm
        List<OrderItem> newOrderItem = new List<OrderItem>();
        //creates a list for all pricebookEntries fields related to the items
        List<PricebookEntry> allPricebookEntries = [SELECT id, Product2Id, Pricebook2Id, UnitPrice FROM PricebookEntry];
        //creates a list of only the priceBook enrtries related to the current order items
        List<PricebookEntry> relatedPricebookEntries = new List<PricebookEntry>();
        //creates a list of all the unit prices for the current order items
        List<Decimal> unitPrice = new List<Decimal>();
        //two enhanced for-loops to select pricebook entries and order them in the list corresponding to the order of the products selected
        for(String product2Id : product2Ids){
            for(PricebookEntry allPricebookEntry : allPricebookEntries){
                if(allPricebookEntry.Pricebook2Id == pricebook2Id && allPricebookEntry.Product2Id == product2Id){
                     relatedPricebookEntries.add(allPricebookEntry);
                }//end if
            }//end for pricebookEntry
        }//end for productId
        //two enhanced for-loops to select the unit price for each product selected and order them in the list
        for(String product2Id : product2Ids){
            for(PricebookEntry relatedPricebookEntry : relatedPricebookEntries){
                if(relatedPricebookEntry.Product2Id == product2Id){
                    unitPrice.add(relatedPricebookEntry.UnitPrice);
                }//end if
            }//end for pricebookEntry
        }//end for productId
        //for loop to add as many orderItems as their are products
        for(Integer i = 0; i < totalItems; i++){
            newOrderItem.add(new OrderItem(OrderId = currOrder.Id, PricebookEntryId = relatedPricebookEntries[i].Id, Product2Id = product2Ids[i], Quantity = pQuantity[i], UnitPrice = unitPrice[i]));
        }//end for i
        //try the insertion
        try {
            insert newOrderItem;
            testResult = true;

        } catch (Exception e) {
            //throw new AuraHandledException(e.getMessage());
            testResult = false;
        }
        return testResult;
    }//end CreateOrderItems
}//end class