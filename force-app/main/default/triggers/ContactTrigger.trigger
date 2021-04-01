trigger ContactTrigger on Contact (after insert,after update,after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT{
            
        }
        when AFTER_INSERT{
            contactUpdateClass.afterInsertHandler(Trigger.New);
            
        }
        when AFTER_UPDATE{
            contactUpdateClass.afterUpdateHandler(Trigger.New,Trigger.oldMap);
            
        }
        when AFTER_DELETE{
            //contactUpdateClass.updateAccountRecord(Trigger.New);
        }
    }
}