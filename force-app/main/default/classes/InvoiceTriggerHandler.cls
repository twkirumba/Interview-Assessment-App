public with sharing class InvoiceTriggerHandler {
    public InvoiceTriggerHandler() {

    }

    public static void beforeUpdateHandler(Map<Id, Invoice__c> oldMap, Map<Id, Invoice__c> newMap){
        //(Tony - 09/19/2022) prevent invoices from being updated if they were not set to active before the update
        preventUpdateInactiveInvoiceExceptFlowContext(oldMap, newMap);
    }

    public static void preventUpdateInactiveInvoice(Map<Id, Invoice__c> oldMap, Map<Id, Invoice__c> newMap){
        for(Id key : oldMap.keySet()){
            if(oldMap.get(key).Active__c == false && newMap.get(key).Active__c == false){
                newMap.get(key).addError('Invoice cannot be updated while it is Inactive. Please mark the invoice "Active" and try again');
            }
        }
    }

    //return true if the request is currently in Flow/Process Builder Context
    //(Tony - 09/21/2022): Including this because the flow challenge fails without it - flow updates inactive records as well. 
    public static Boolean isVFContext(){
        //System.debug('Context --> ' + Request.getCurrent().getQuiddity().name());
         if(Request.getCurrent().getQuiddity().name() == 'VF'){
            return true;
         }
         return false;
    }
    
    public static void preventUpdateInactiveInvoiceExceptFlowContext(Map<Id, Invoice__c> oldMap, Map<Id, Invoice__c> newMap){
        if(isVFContext()){
            preventUpdateInactiveInvoice(oldMap, newMap);
        }
    }
    
}