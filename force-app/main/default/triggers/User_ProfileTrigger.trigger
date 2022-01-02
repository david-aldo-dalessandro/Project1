//David D'Alessandro
//12/28/21
//User_Profile Trigger


trigger User_ProfileTrigger on User_Profile__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on trigger.operationType{

        when BEFORE_INSERT{
            User_ProfileTriggerHelper.User_ProfileValidateDuplicate(trigger.new);
        }

        when BEFORE_UPDATE{
            User_ProfileTriggerHelper.User_ProfileValidateDuplicate(trigger.new);
        }

        when BEFORE_DELETE{
            
        }

        when AFTER_INSERT{
            
        }

        when AFTER_UPDATE{
            
        }

        when AFTER_DELETE{
            
        }

        when AFTER_UNDELETE{
            
        }

    }

}