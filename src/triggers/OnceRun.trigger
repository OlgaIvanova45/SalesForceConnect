/**
 * Created by Оля on 3/4/2021.
 */

trigger OnceRun on Account (before insert) {
    if(OnceRunTriggerHandler.firstRun == 1) {
       OnceRunTriggerHandler.firstRun=2; 
       for (Account acc : Trigger.new) {
       acc.Description = 'Trigger worked on this account';
     
       }    
    }    
}