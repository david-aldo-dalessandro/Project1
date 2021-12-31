//David D'Alessandro
//12/31/21
//Product Trigger

trigger ProductTrigger on Product2 (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on trigger.operationType{

        when BEFORE_INSERT{
            //validate duplicates
        }

        when BEFORE_UPDATE{
            //validate duplicates
        }

        when BEFORE_DELETE{

        }

        when AFTER_INSERT{
            ProductTriggerHelper.LinkPricebookEntry(trigger.new);
        }

        when AFTER_UPDATE{

        }

        when AFTER_DELETE{
            //delete associated pricebook
        }

        when AFTER_UNDELETE{

        }

    }

}