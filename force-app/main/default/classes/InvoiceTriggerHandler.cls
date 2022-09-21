public with sharing class InvoiceTriggerHandler {
    public InvoiceTriggerHandler() {

    }

    public static void beforeUpdateHandler(Map<Id, Invoice__c> oldMap, Map<Id, Invoice__c> newMap){
        //(Tony - 09/19/2022) prevent invoices from being updated if they were not set to active before the update
        preventUpdateInactiveInvoice(oldMap, newMap);
    }

    public static void preventUpdateInactiveInvoice(Map<Id, Invoice__c> oldMap, Map<Id, Invoice__c> newMap){
        for(Id key : oldMap.keySet()){
            if(oldMap.get(key).Active__c == false && newMap.get(key).Active__c == false){
                newMap.get(key).addError('Invoice cannot be updated while it is Inactive. Please mark the invoice "Active" and try again');
            }
        }
    }
}