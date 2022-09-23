public with sharing class ZeroInvoiceTaxController {
  
  private List<Invoice__c> invoiceList {get;set;}

  private PageReference cancel {get;set;}
  
  public ZeroInvoiceTaxController(ApexPages.StandardSetController ctl) {
    invoiceList = ctl.getSelected();
    System.debug('InvoiceList --> ' + invoiceList);
    cancel = ctl.cancel();    
  }

  public PageReference zeroTaxHandler(){
    
    List<Invoice__c> invList = setZeroTax(invoiceList);
    updateInvList(invList);

    ApexPages.Message msg1 = new ApexPages.Message(
      ApexPages.Severity.INFO,
      'Invoices Successfully Updated. Returning to List View'
    );
    ApexPages.addMessage(msg1);

    return null;
  }

  public List<Invoice__c> setZeroTax(List<Invoice__c> invList) {
    ApexPages.Message msg = new ApexPages.Message(
      ApexPages.Severity.INFO,
      'Iterating through selected invoices and setting Tax = 0.00...'
    );
    ApexPages.addMessage(msg);

    for (Invoice__c inv : invList) {
      inv.Tax__c = 0.00;
    }

    return invList;
  }

  public void updateInvList(List<Invoice__c> invList) {
    ApexPages.Message msg1 = new ApexPages.Message(
      ApexPages.Severity.INFO,
      'Updating Invoices in Database...'
    );
    ApexPages.addMessage(msg1);

    update invList;
  }

  public PageReference returnToListView(){
    return cancel;
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 3c1cd323e6df89a442a869499b01bee069787a50
