/**
 * CTPersonController
 * @Author Sudheer Kumar Gandham 
 */

    public with sharing class CTPersonController {
    /** Generate a secret token using MD5 hash
     * @parameter mobileNumber
     * 
     */
    /**
     * Get 100 contacts with recent health status change
     * @return List<Person__c>
     */
    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    /**
     * Search a person by name, token or mobile
     * @return List<Person__c>
     */
    public static List<Person__c> searchPeople(String searchTerm){
        // appending the wild card
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
            FROM Person__c
            WHERE Name LIKE :searchTerm
                OR Mobile__c LIKE :searchTerm
                OR Token__c LIKE :searchTerm
            ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    /**
     * Search a person by id
     * @return Person__c
     */
    public static Person__c getPersonById(String personId){
        List<Person__c> people = [SELECT Id, Name, Health_Status__c, Mobile__c, 
                Status_Update_Date__c, Token__c
                FROM Person__c
                WHERE Id =:personId];
        if(people != null && people.size() > 0){
            return people[0];
        }
        return null;
    }

    /**
    * @description 
    * @author Sudheer Kumar Gandham | 29-03-2021 
    * @return Map<String, Integer> 
    **/
    public static Map<String,Integer> getHealthStatusCount(){
        Map<String,Integer> mapHealthStatus = new Map<String,Integer>();
        for(AggregateResult var : [SELECT Health_Status__c healthStatusCode,COUNT(Id) numberOfPersons FROM Person__c GROUP BY Health_Status__c]) {
            // map Healthstatuscode and Count
            mapHealthStatus.put(String.valueOf(var.get('healthStatusCode')), Integer.valueOf(var.get('numberOfPersons')));
        }
        return mapHealthStatus;
    }

}
