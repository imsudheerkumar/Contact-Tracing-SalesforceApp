/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 29-03-2021
 * @last modified by  : Sudheer Kumar Gandham
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   03-26-2021   Sudheer Kumar Gandham   Initial Version
**/
public with sharing class CTLocationController {
    /**
     * Get 100 locations with recent health status change
     * @return List<Location__c>
     */
    public static List<Location__c> getRecentStatusChanges(){
        return [SELECT
        Id,
        Address__c,
        Name,
        Pincode__c,
        Red_Score__c,
        Status__c,
        Status_Update_Date__c
    FROM
        Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    /**
     * Search a person by name, token or mobile
     * @return List<Person__c>
     */
    public static List<Location__c> searchLocations(String searchTerm){
        // appending the wild card
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Pincode__c, Address__c,Red_Score__c,Status__c, Status_Update_Date__c
            FROM Location__c
            WHERE Name LIKE :searchTerm
                OR Pincode__c LIKE :searchTerm
                OR Address__c LIKE :searchTerm
                WITH SECURITY_ENFORCED
                ORDER BY Status_Update_Date__c  DESC NULLS LAST ];
    }

    /**
     * Search a person by id
     * @return Person__c
     */
    public static Location__c getLocationById(String locationId){
        List<Location__c> locationdetail = [SELECT Id, Name, Pincode__c, Address__c,Red_Score__c,Status__c, Status_Update_Date__c 
                                        FROM Location__c WHERE Id =:locationId WITH SECURITY_ENFORCED ];
        if(locationdetail != null && locationdetail.size() > 0){
            return locationdetail[0];
        }
        return null;
    }

    public static Map<String,Integer> getStatusCount(){
        Map<String,Integer> mapHealthStatus = new Map<String,Integer>();
        for(AggregateResult var : [SELECT Status__c status, COUNT(Id) statusCount FROM Location__c GROUP BY Status__c]) {
            // map Healthstatuscode and Count
            mapHealthStatus.put(String.valueOf(var.get('status')), Integer.valueOf(var.get('statusCount')));
        }
        return mapHealthStatus;
    }

}
