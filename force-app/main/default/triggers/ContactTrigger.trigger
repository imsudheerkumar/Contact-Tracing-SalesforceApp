/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 02-04-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   01-04-2021   Sudheer Kumar Gandham   Initial Version
**/
trigger ContactTrigger on Contact (after insert,after update,after delete, after undelete) {
    switch on Trigger.operationType {
        when AFTER_INSERT{
            contactUpdateClass.afterInsertHandler(Trigger.new);
        }
        when AFTER_UPDATE{
            contactUpdateClass.afterUpdateHandler(Trigger.new,Trigger.oldMap);
        }
        when AFTER_DELETE{
            contactUpdateClass.afterDeleteHandler(Trigger.old);
        }
        when AFTER_UNDELETE{
            contactUpdateClass.afterUndeleteHandler(Trigger.new);
        }
    }
}