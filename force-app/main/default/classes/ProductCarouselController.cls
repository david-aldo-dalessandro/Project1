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

    @AuraEnabled
    public static void InsertProducts(List<Product2> newProducts){
        try{
            insert newProducts;
        }
        catch(Exception exp){
            throw new AuraHandledException(exp.getMessage());
        }
    }//end InsertProducts
}
