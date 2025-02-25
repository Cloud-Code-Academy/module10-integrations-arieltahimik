/*
* ContactTrigger Trigger Description:
* 
* The ContactTrigger is designed to handle various logic upon the insertion and update of Contact records in Salesforce. 
* 
* Optional Challenge: Use a trigger handler class to implement the trigger logic.
 */

trigger ContactTrigger on Contact(before insert, before update) {
	new ContactTriggerHandler().run();
}