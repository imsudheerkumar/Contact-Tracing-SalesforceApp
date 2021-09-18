/**
 * @description       : 
 * @author            : Sudheer Kumar Gandham
 * @group             : 
 * @last modified on  : 17-09-2021
 * @last modified by  : Sudheer Kumar Gandham
**/
public with sharing class ApexUtil {
    public static Map<String, String> getObjectAPINameToLabel() {

        // * Initializing Map
        Map<String, String> objectAPINameToLabelMap = new Map<String, String>();

        // * Getting all sObjects metadata
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();

        // * Processing each sObject one by one
        for(String globalDescribeKey : globalDescribeMap.keySet()) {

            // * Getting the current sObject type
            Schema.SObjectType currentSObjectType = globalDescribeMap.get(globalDescribeKey);

            // * Getting the current sObject description result from sObject Type
            Schema.DescribeSObjectResult currentSObjectResult = currentSObjectType.getDescribe();

            // * Getting the API name and value of current sObject and adding it to the map
            objectAPINameToLabelMap.put(currentSObjectResult.getName(), currentSObjectResult.getLabel());
        }

        // * Returning the map
        return objectAPINameToLabelMap;
    }
}

