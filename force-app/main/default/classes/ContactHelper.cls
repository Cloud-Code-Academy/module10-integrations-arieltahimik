/*
* Key Behaviors:
* 1. When a new Contact is inserted and doesn't have a value for the DummyJSON_Id__c field, 
*    the trigger generates a random number between 0 and 100 for it.
* 2. Upon insertion, if the generated or provided DummyJSON_Id__c value is less than or equal to 100, 
*    the trigger initiates the getDummyJSONUserFromId API call.
* 3. If a Contact record is updated and the DummyJSON_Id__c value is greater than 100, 
*    the trigger initiates the postCreateDummyJSONUser API call.
*
*
* Best Practices for Callouts in Triggers:
* 
* 1. Avoid Direct Callouts: Triggers do not support direct HTTP callouts. 
*    Instead, use asynchronous methods like @future or Queueable to make the callout.
* 2. Bulkify Logic: Ensure that the trigger logic is bulkified so that it can 
*    handle multiple records efficiently without hitting governor limits.
* 3. Avoid Recursive Triggers: Ensure that the callout logic doesn't result in changes 
*    that re-invoke the same trigger, causing a recursive loop.
*
*/

public with sharing class ContactHelper {

    public static void insertNewContacts(List<Contact> newContacts) {
        Integer randomNumber;
        final Integer MIN =   0;
        final Integer MAX = 100;

        for (Contact con : newContacts) {
            // When a contact is inserted
            if (con.DummyJSON_Id__c == null) {
                randomNumber = (Integer) (Math.random() * (MAX - MIN + 1)) + MIN;
                con.DummyJSON_Id__c = String.valueOf(randomNumber);
            }

            // When a contact is inserted
            // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
            if (Integer.valueOf(con.DummyJSON_Id__c) <= 100) {
                DummyJSONCallout.getDummyJSONUserFromId(con.DummyJSON_Id__c);
            }
        }
    }

    public static void updateContacts(List<Contact> newContacts, List<Contact> oldContacts) {
        for (Contact con : newContacts) {
            for (Contact oldCon : oldContacts) {
                // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
                if (Integer.valueOf(con.DummyJSON_Id__c) > 100) {
                    //DummyJSONCallout.postCreateDummyJSONUser(con.Id);
                    System.debug('Callout to postCreateDummyJSONUser API initiated for Contact Id: ' + con.Id);
                }
            }
        }
    }
}
