public class QueueableForAccounts implements Queueable{
   
   public void execute(QueueableContext context) {
   		List<Contact> contactsList = [SELECT Id, Is_Synced__c, Processed_By_Queue__c FROM Contact WHERE
										Account.BillingStreet != NULL
										OR Account.BillingCity != NULL
										OR Account.BillingState != NULL
										OR Account.BillingPostalCode != NULL
										OR Account.BillingCountry != NULL];
                    for (Contact cont : contactsList) {
                        if (cont.Is_Synced__c == true &&
                            cont.Processed_By_Queue__c == false) {
                            cont.Is_Synced__c = false;
                            cont.Processed_By_Queue__c = true;
                            }
                    }
                    
                    update contactsList;
	}
}