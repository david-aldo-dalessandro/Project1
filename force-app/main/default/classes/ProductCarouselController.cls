//David D'Alessandro
//12/26/21
//Product page controller

public with sharing class ProductCarouselController {
    

    @AuraEnabled(cacheable=true)
    public static List<Product2> GetProducts(){
        List<Product2> currProducts = new List<Product2>();

        currProducts = [SELECT name, description FROM Product2];


        return currProducts;

    }//end GetProducts

    @AuraEnabled(cacheable=true)
    public static List<Contract> GetContracts(String id){
        List<Contract> currContracts = new List<Contract>();

        currContracts = [SELECT Id, ContractNumber FROM Contract WHERE AccountId = :id];

        return currContracts;
    }

    @AuraEnabled
    public static Order InsertOrder(String accountId, String contractId){
        Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true];
        Order newOrder = new Order(AccountId = accountId, ContractId = contractId, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id = standardPricebook.Id);
        try{
            insert newOrder;
        }
        catch(Exception exp){
            throw new AuraHandledException(exp.getMessage());
        }
        return newOrder;
    }//end InsertOrder

    @AuraEnabled
    public static Boolean CreateOrderItems(List<String> product2Ids, List<Integer> pQuantity, Integer totalItems, String accountId){

        Boolean val = false;

        Order currOrder = [SELECT Id, Pricebook2Id FROM Order WHERE AccountId = :accountId LIMIT 1];
        String pricebook2Id = currOrder.Pricebook2Id;

        List<OrderItem> newOrderItem = new List<OrderItem>();
        List<PricebookEntry> allPricebookEntries = [SELECT id, Product2Id, Pricebook2Id, UnitPrice FROM PricebookEntry];

        List<PricebookEntry> relatedPricebookEntries = new List<PricebookEntry>();
        System.debug('product2 size ' + product2Ids.size());
        System.debug('Quantities size ' + pQuantity.size());

        List<Decimal> unitPrice = new List<Decimal>();

        for(String product2Id : product2Ids){
            for(PricebookEntry allPricebookEntry : allPricebookEntries){
                if(allPricebookEntry.Pricebook2Id == pricebook2Id && allPricebookEntry.Product2Id == product2Id){
                     relatedPricebookEntries.add(allPricebookEntry);
                }
            }
        }

        System.debug('Size of relatedPricebookEntries ' + relatedPricebookEntries.size());

        for(String product2Id : product2Ids){
            for(PricebookEntry relatedPricebookEntry : relatedPricebookEntries){
                if(relatedPricebookEntry.Product2Id == product2Id){
                    unitPrice.add(relatedPricebookEntry.UnitPrice);
                }
            }
        }
        System.debug('Unit Price size ' + unitPrice.size());

      
        for(Integer i = 0; i < totalItems; i++){
            newOrderItem.add(new OrderItem(OrderId = currOrder.Id, PricebookEntryId = relatedPricebookEntries[i].Id, Product2Id = product2Ids[i], Quantity = pQuantity[i], UnitPrice = unitPrice[i]));
        }//end for i
       

        try {
            insert newOrderItem;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        

    }
}

