trigger ContactTrigger on Contact (after insert,after update,after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT{
            
        }
        when AFTER_INSERT{
            contactUpdateClass.afterInsertHandler(Trigger.New);
            
        }
        when BEFORE_UPDATE{
            
        }
        when AFTER_UPDATE{
           // contactUpdateClass.afterUpdateHandler(Trigger.New,Trigger.Oldmap);
            
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_DELETE{
            //contactUpdateClass.updateAccountRecord(Trigger.New);
        }
    }
    
    
}