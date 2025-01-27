/*
* Key Behaviors:
* 1. When a new Contact is inserted and doesn't have a value for the DummyJSON_Id__c field, 
*    the trigger generates a random number between 0 and 100 for it.
* 2. Upon insertion, if the generated or provided DummyJSON_Id__c value is less than or equal to 100, 
*    the trigger initiates the getDummyJSONUserFromId API call.
* 3. If a Contact record is updated and the DummyJSON_Id__c value is greater than 100, 
*    the trigger initiates the postCreateDummyJSONUser API call.
*/
public with sharing class ContactTriggerHandler extends TriggerHandler {

    // Private Collection Variables

    private List<Contact> newConList;
    private List<Contact> oldConList;
    private Map<Id, Contact> newConMap;
    private Map<Id, Contact> oldConMap;

    // Constructor

    public ContactTriggerHandler() {
        this.newConList = (List<Contact>) Trigger.new;
        this.oldConList = (List<Contact>) Trigger.old;
        this.newConMap = (Map<Id,Contact>) Trigger.newMap;
        this.oldConMap = (Map<Id,Contact>) Trigger.oldMap;        
    }

    // Trigger Contexts

    public override void beforeInsert() {
        ContactHelper.insertNewContacts(newConList);
    }


    public override void beforeUpdate() {
        ContactHelper.updateContacts(newConList, oldConList);
    }

}