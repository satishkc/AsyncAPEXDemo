/**
 * @description       : 
 * @author            : Satish Chandrashekar
 * @group             : 
 * @last modified on  : 03-15-2021
 * @last modified by  : Satish Chandrashekar
 * Modifications Log 
 * Ver   Date         Author                 Modification
 * 1.0   03-11-2021   Satish Chandrashekar   Initial Version
**/
public with sharing class SendLoanToDAQueueable implements Queueable, Database.AllowsCallouts {
        
        public LLC_BI__Loan__c singleLoan;
        public SendLoanToDAQueueable(LLC_BI__Loan__c singleLoan){
        this.singleLoan = singleLoan ; 
        }

    public void execute(QueueableContext context) {
       
        //do some query to get the entity involvments
        List<LLC_BI__Legal_Entities__c> eiList = class.getEntityInvolvmentData(singleLoan);


        //do something to get all the relationships and applicant data
        List<CustomApexObject.ApplicantData> applicantData = getApplicantData(eiList);
        
        
        //do something to generate the payload here
        String payloadString = generatePayload(singleLoan, eiList, applicantData);
        
        //do something to send payload here
        String responseString = doCallout(payloadString);
        
        
        //do something to handle response here
        List<sObject> resultObjects = someCodeToValidate();
        
        
        //do DML inserts here to upsert the results into the DAT History Records
        upsert resultObjects;
        
    }
}