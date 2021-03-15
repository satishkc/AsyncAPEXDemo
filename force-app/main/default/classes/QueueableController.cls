/**
 * @description       : 
 * @author            : Satish Chandrashekar
 * @group             : 
 * @last modified on  : 03-12-2021
 * @last modified by  : Satish Chandrashekar
 * Modifications Log 
 * Ver   Date         Author                 Modification
 * 1.0   03-11-2021   Satish Chandrashekar   Initial Version
**/
public with sharing class QueueableController {
    

    //Invocable Method to set a Queueable Job by Contact.
    @InvocableMethod(label='getContacts' description='Get the list of Contacts.' category='Contact')
    public static void getContacts(List<Id> acclist){
        Id accid = acclist[0];
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId  =: accid];
        Map<Id, Id> historyMap = new Map<Id, Id>();
        List<Id> jId = new List<Id>();
        
        for(Contact con : conList){
            getFlightsQueueable qDA = new getFlightsQueueable(con);
            qDA.singleContact = con;
            Id jobId = system.enqueueJob(qDA);
            historyMap.put(con.Id, JobId);
            jId.add(JobId);
            System.Debug('Job Submitted' + JobId + 'for Contact' + con.Id);
        }
        //Execute DML Statement to add JOB ID to Contact Record
        system.debug(JSON.serializePretty(jId));
        
    }
}
