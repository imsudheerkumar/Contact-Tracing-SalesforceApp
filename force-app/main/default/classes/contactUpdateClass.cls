public class contactUpdateClass {
    public static void afterInsertHandler(List<Contact> contactRecords){
        
        Set<Id> AccountIds = new Set<Id>();
        for(Contact con : contactRecords){
            if(String.isNotBlank(con.AccountId) && con.isActive__c == true){
                AccountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(AccountIds);
    }
    
    public static void afterUpdateHandler(List<Contact> contactRecords, Map<Id,Contact> oldContactsMap){
        Set<Id> AccountIds = new Set<Id>();
        for(Contact con : contactRecords){
            if(String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).isActive__c != con.isActive__c){
                AccountIds.add(con.AccountId);
            } else if (oldContactsMap.get(con.Id).AccountId!= con.AccountId){
                AccountIds.add(oldContactsMap.get(con.Id).AccountId);
                AccountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(AccountIds);
    }
    
}