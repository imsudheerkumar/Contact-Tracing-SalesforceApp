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
@isTest
public with sharing class ContactTriggerHandlerTest {

    @isTest
    public static void afterInsertHandlerTest() {

        //insert some accounts first 
        List<Account> accountsToInsert = new List<Account>();
        for(Integer i = 1; i <=100; i++)
        {
            accountsToInsert.add(new Account(Name='TEST ACCOUNT '+i));
        }
        insert accountsToInsert;
        System.assertEquals(accountsToInsert.size(),100,'INSERTED 100 ACCOUNTS');

        // insert some contacts to these accounts
        List<Contact> cons = new List<Contact>();
        for(Integer i = 1; i<=accountsToInsert.size()-50;i++)
        {
            cons.add(new Contact(LastName='ACC '+i +' '+ 'CONTACT '+i, isActive__c =true, AccountId=accountsToInsert[1].Id));
        }
        insert cons;
        System.assertEquals(cons.size(),50,'INSERTED 50 CONTACTS TO THIER RESPECTIVE ACCOUNTS');

        List<Account> accls = [SELECT Id, Name , Active_Contacts__c FROM Account];
        
        for(Account acc : accls){
            if(acc.Name == 'TEST ACCOUNT 2'){
                System.assertEquals(50, acc.Active_Contacts__c,'EQUAL');
            }
        }
    }
}
