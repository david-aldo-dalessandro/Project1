//David D'Alessandro
//12/21/21
//Account Trigger 

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    switch on trigger.operationType {

        when BEFORE_INSERT{

            AccountTriggerHelper.AccountValidateEmpty(trigger.new);
            //AccountTriggerHelper.AccountValidateDuplicate(trigger.new);
        }

        when BEFORE_UPDATE{

            AccountTriggerHelper.AccountValidateEmpty(trigger.new);
            //AccountTriggerHelper.AccountValidateDuplicate(trigger.new);

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