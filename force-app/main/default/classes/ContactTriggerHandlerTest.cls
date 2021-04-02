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

        //this operation will call the afterInsertHandler in the Trigger
        List<Contact> cons = new List<Contact>();
        for(Integer i = 1; i<=accountsToInsert.size()-50;i++)
        {
            cons.add(new Contact(LastName='ACC '+i +' '+ 'CONTACT '+i, isActive__c =true, AccountId=accountsToInsert[1].Id));
        }
        insert cons;
        System.assertEquals(cons.size(),50,'INSERTED 50 CONTACTS TO THIER RESPECTIVE ACCOUNTS');

        //checking if the inserted contacts got updated in the Account 
        List<Account> accls = [SELECT Id, Name , Active_Contacts__c FROM Account];
        for(Account acc : accls){
            if(acc.Name == 'TEST ACCOUNT 2'){
                System.assertEquals(50, acc.Active_Contacts__c,'EQUAL');
            }
        }
    }

    @isTest
    public static void afterUpdateHandlerTest() {
                //insert some accounts first 
                List<Account> accounts = new List<Account>();
                for(Integer i = 1; i <=100; i++)
                {
                    accounts.add(new Account(Name='TEST ACCOUNT '+i));
                }
                insert accounts;
                System.assertEquals(accounts.size(),100,'INSERTED 100 ACCOUNTS');
        
                //this operation will call the afterInsertHandler in the Trigger
                List<Contact> contacts = new List<Contact>();
                for(Integer i = 1; i<=accounts.size()-50;i++)
                {
                    contacts.add(new Contact(LastName='ACC '+i +' '+ 'CONTACT '+i, isActive__c =true, AccountId=accounts[1].Id));
                }
                insert contacts;
                System.assertEquals(contacts.size(),50,'INSERTED 50 CONTACTS TO THIER RESPECTIVE ACCOUNTS');

                // updating a contact 
                List<Contact> lscontacts = [SELECT Id, Name ,LastName, isActive__c FROM Contact];
                for(Contact con : lscontacts){
                    if(con.LastName == 'ACC 10 CONTACT 10'){
                        con.isActive__c = false;
                    }
                }
                //allocate new set of Governor Limits
                Test.startTest();
                update lscontacts;
                Test.stopTest();
                //checking the Active_Contacts__c count number
                List<Account> accls = [SELECT Id, Name , Active_Contacts__c FROM Account];
                for(Account acc : accls){
                    if(acc.Name == 'TEST ACCOUNT 2'){
                        System.assertEquals(49, acc.Active_Contacts__c,'EQUAL');
                    }
        }
        
    }
}
