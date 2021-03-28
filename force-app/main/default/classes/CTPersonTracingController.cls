/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 28-03-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   28-03-2021   Sudheer Kumar Gandham   Initial Version
**/
public with sharing class CTPersonTracingController {
    /**
    * @description 
    * @author Sudheer Kumar Gandham | 28-03-2021 
    * @return List<Person__c> 
    **/
    public static List<People_Tracing__c> getRecentHealthChanges(String recordId){
        return [SELECT Id, Name, Person_1__c, Person_2__c, Contact_Type__c,
                Person_1__r.Health_Status__c,Person_1__r.Token__c,
                Person_2__r.Health_Status__c,Person_2__r.Token__c,
                Contact_Date__c FROM People_Tracing__c 
                WHERE Id=:recordId WITH SECURITY_ENFORCED 
                ORDER BY Contact_Date__c];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces){
        return null;
    }
}
