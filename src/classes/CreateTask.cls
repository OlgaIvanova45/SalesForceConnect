public with sharing class CreateTask {

    @InvocableMethod
    public static void createTask(List<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        List<Task> tasks = [SELECT Id, WhatId FROM Task WHERE WhatId IN :accountIds];
        User userForTasks = [SELECT Id FROM User WHERE IsActive = TRUE LIMIT 1];
        List<Task> tasksToUpsert = new List<Task>();

        for (Account acc : accounts) {
            List<Task> accTasks = new List<Task>();

            for (Task tsk : tasks) {
                if (tsk.WhatId == acc.Id) {
                    accTasks.add(tsk);
                }

            }

            if (accTasks.isEmpty()) {
                Task newtsk = new Task(Subject = 'Negotiation with ' + acc.Name, WhatId = acc.Id);
                tasksToUpsert.add(newtsk);
            }

            if (accTasks.size() > 3) {

                for (Task acctask : accTasks) {
                    acctask.OwnerId = userForTasks.Id;
                }
                tasksToUpsert.addAll(accTasks);
            }


        }
        upsert tasksToUpsert;

    }

}