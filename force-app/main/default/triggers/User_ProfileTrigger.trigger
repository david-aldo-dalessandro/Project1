//David D'Alessandro
//12/28/21
//User_Profile Trigger


trigger User_ProfileTrigger on User_Profile__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on trigger.operationType{

        when BEFORE_INSERT{

        }

        when BEFORE_UPDATE{

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