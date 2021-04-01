/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 01-04-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   01-04-2021   Sudheer Kumar Gandham   Initial Version
**/
trigger ContactTrigger on Contact (after insert,after update,after delete, after undelete) {
    switch on Trigger.operationType {
        when AFTER_INSERT{
            contactUpdateClass.afterInsertHandler(Trigger.New);
        }
        when AFTER_UPDATE{
            contactUpdateClass.afterUpdateHandler(Trigger.New,Trigger.oldMap);
        }
        when AFTER_DELETE{
            //contactUpdateClass.updateAccountRecord(Trigger.New);
        }
        when AFTER_UNDELETE{
            //
        }
    }
}