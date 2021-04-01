public class AccountContactServices {
    public static void updatingAccountRecords(Set<Id> AccountIDs)
    {
        List<AggregateResult> Result = [SELECT AccountId, COUNT(Id) TotalContacts FROM Contact WHERE isActive__c=TRUE AND AccountId IN :AccountIDs GROUP BY AccountId];
        List<Account> recordstoUpdate = new List<Account>();
        
        for(AggregateResult aggre :Result){
            String AccId = String.valueOf(aggre.get('AccountId'));
            Integer TotalContacts =Integer.valueOf(aggre.get('TotalContacts'));
            Account acc = new Account(Id = AccId, Active_Contacts__c = TotalContacts );
            recordstoUpdate.add(acc);
        }
        update recordstoUpdate;
    }
    
}