trigger InvoiceTrigger on Invoice__c (before update) {

    if(trigger.isBefore){
        if(trigger.isUpdate){
            InvoiceTriggerHandler.beforeUpdateHandler(trigger.oldMap, trigger.NewMap);
        }
    }

}