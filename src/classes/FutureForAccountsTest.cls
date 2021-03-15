@isTest
public class FutureForAccountsTest {
    @isTest static void TestFutureAccounts () {
        List<Account> accountForfutureTest = new List<Account>();
         List<Contact> testFutureContacts = new List<Contact>();
        
        for (Integer i = 0; i < 150; i++) {
            accountForfutureTest.add(new Account(Name = 'Test Account ' + i, BillingCountry = 'Russia'));
           	
            //можно ли в тесте выводить? System.debug(accountForfutureTest);
        }
		 insert accountForfutureTest;
        
        for (Account acc : accountForfutureTest) {
            for (Integer j = 0; j < 1; j++) {
            
                testFutureContacts.add(new Contact(LastName = 'LN ' + j, Is_Synced__c = true, Processed_By_Future__c = false, AccountId = acc.Id));
        	} 
        }
        insert testFutureContacts;
        
        Test.startTest();
        FutureForAccounts.relatedContactsForAccounts();
        Test.stopTest();

        List<Contact> contacts = [SELECT Id FROM Contact WHERE Is_Synced__c = false AND Processed_By_Future__c = true];
        System.assertEquals(150, contacts.size());
    }
}