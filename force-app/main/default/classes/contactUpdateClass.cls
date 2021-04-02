/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 02-04-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   02-04-2021   Sudheer Kumar Gandham   Initial Version
**/
public class contactUpdateClass {
    public static void afterInsertHandler(List<Contact> contactRecords){ 
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : contactRecords){
            if(String.isNotBlank(con.AccountId) && con.isActive__c == true){
                accountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(AccountIds);
    }
    
    public static void afterUpdateHandler(List<Contact> contactRecords, Map<Id,Contact> oldContactsMap){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : contactRecords){
            if(String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).isActive__c != con.isActive__c){
                accountIds.add(con.AccountId);
            } else if (oldContactsMap.get(con.Id).AccountId!= con.AccountId){
                accountIds.add(oldContactsMap.get(con.Id).AccountId);
                accountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(AccountIds);
    }

    public static void afterDeleteHandler(List<Contact> oldContactRecords){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : oldContactRecords){
            if(String.isNotBlank(con.AccountId)){
                accountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(accountIds);
    }


    public static void afterUndeleteHandler(List<Contact> newContactRecords){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : newContactRecords){
            if(String.isNotBlank(con.AccountId)){
                accountIds.add(con.AccountId);
            }
        }
        //calling updatingAccountRecords class
        AccountContactServices.updatingAccountRecords(accountIds);
    }
}