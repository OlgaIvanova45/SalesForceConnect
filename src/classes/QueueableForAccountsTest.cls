@isTest
public class QueueableForAccountsTest {
    @isTest static void test1() {
        
        
        Account acc = new Account();
        acc.Name = 'Test1';
        acc.BillingCountry = 'Russia';
        acc.BillingCity = 'Moscow';
        insert acc;
        Contact cont = new Contact();
        cont.FirstName = 'Vasya';
        cont.LastName = 'Pupkin';
        cont.AccountId = acc.Id;
        cont.Is_Synced__c = true;
        cont.Processed_By_Queue__c = false;
        insert cont;

        
        Test.startTest();
        System.enqueueJob(new QueueableForAccounts());
        Test.stopTest();

        System.assert(acc != null );
        System.assert(cont != null );
    }


}
    
