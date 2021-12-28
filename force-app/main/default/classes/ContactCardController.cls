//David D'Alessandro
// 12/24/21
//Controller for Contact Card Web Component 
public with sharing class ContactCardController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> GetContactPhoto(){
        List<Contact> contactReturn = [SELECT name, title, phone, email FROM Contact];

        return contactReturn;
    }
    

}
