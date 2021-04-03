/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 03-04-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   02-04-2021   Sudheer Kumar Gandham   Initial Version
**/
@isTest
public with sharing class ContactTriggerHandlerTest {

    @TestSetup
    public static void makeData(){
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
    }

    @isTest
    public static void afterInsertHandlerTest1() {
        //checking if the inserted contacts got updated in the Account 
        List<Account> accls = [SELECT Id, Name , Active_Contacts__c FROM Account];
        for(Account acc : accls){
            if(acc.Name == 'TEST ACCOUNT 2'){
                System.assertEquals(50, acc.Active_Contacts__c,'EQUAL');
            }
        }
    }

    @isTest
    public static void afterUpdateHandlerTest1() {
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
    @isTest
    public static void afterUpdateHandlerTest2() {
        // updating a contact - changing account from one account to another
        Account acc = [SELECT Id ,Name  FROM Account WHERE Name ='TEST ACCOUNT 3'];
        List<Contact> lscontacts = [SELECT Id, Name ,LastName, isActive__c FROM Contact];
        for(Contact con : lscontacts){
            if(con.LastName == 'ACC 10 CONTACT 10'){
                con.isActive__c = true;
                con.AccountId = acc.Id;
            }
        }
        //allocate new set of Governor Limits
        Test.startTest();
        update lscontacts;
        Test.stopTest();
        //checking the Active_Contacts__c count number
        List<Account> accls = [SELECT Id, Name , Active_Contacts__c FROM Account];
        for(Account accounttest : accls){
            if(accounttest.Name == 'TEST ACCOUNT 3'){
                System.assertEquals(1, accounttest.Active_Contacts__c,'EQUAL');
            }
        }
    }

    @isTest
    public static void afterDeleteHandler() {
        List<Contact> conlst = [SELECT Id,Name,LastName FROM Contact WHERE LastName IN ('ACC 1 CONTACT 1','ACC 2 CONTACT 2')];
        test.startTest();
        delete conlst;
        test.stopTest();

        List<Account> acclst = [SELECT Id,Name,Active_Contacts__c  FROM Account WHERE Name ='TEST ACCOUNT 2'];
        system.assertEquals(1, acclst.size(),'EQUAL');
        for(Account acclst2 :acclst ){
            system.assertEquals(48, acclst2.Active_Contacts__c , 'EQUAL');
        }

    }

    @isTest
    public static void afterUnDeleteHandler() {
        List<Contact> conlst = [SELECT Id,Name,LastName FROM Contact WHERE LastName IN ('ACC 1 CONTACT 1','ACC 2 CONTACT 2')];
        delete conlst;

        test.startTest();
        undelete conlst;
        test.stopTest();

        List<Account> acclst = [SELECT Id,Name,Active_Contacts__c  FROM Account WHERE Name ='TEST ACCOUNT 2'];
        system.assertEquals(1, acclst.size(),'EQUAL');
        for(Account acclst2 :acclst ){
            system.assertEquals(50, acclst2.Active_Contacts__c , 'EQUAL');
        }

    }

    
}
