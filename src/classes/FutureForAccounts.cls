global class FutureForAccounts {
	@future
    public static void relatedContactsForAccounts () {
        List<Account> accountsList = [SELECT Id, Name, BillingAddress FROM Account LIMIT 150];
        List<Contact> contactsList = [SELECT Id, Is_Synced__c, Processed_By_Future__c, Account.BillingAddress FROM Contact WHERE AccountId IN :accountsList];
           
        for (Contact cont : contactsList) {
            	if (cont.Account.BillingAddress != null) {
                   
                        cont.Is_Synced__c = false;
                        cont.Processed_By_Future__c = true;
                    
                   
        		}
        	}
         update contactsList;
    }
}