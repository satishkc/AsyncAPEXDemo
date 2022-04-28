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
public with sharing class getFlightsQueueable implements Queueable, Database.AllowsCallouts{

    public Contact singleContact;
    
    public getFlightsQueueable(Contact singleContact) {
        this.singleContact = singleContact;
    }

    public void execute(QueueableContext context) {

        //do something to generate the payload here
        Contact con = [SELECT Id, FirstName, LastName, flightResponse__c FROM Contact WHERE Id =: singleContact.Id];
        String str = JSON.serializePretty(con);

        //do something to send payload here
        HTTP h = new HTTP();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://1d2f1354-614b-45e7-9938-5eca16a793c1.mock.pstmn.io/api/flight');
        req.setMethod('GET');
        req.setTimeout(120000);
        HttpResponse resp = h.send(req);
        String responseString = resp.getBody();

        //do something to handle response here
        List<Contact> contlist = [SELECT Id, flightResponse__c FROM Contact WHERE Id =: singleContact.Id];
        for(Contact c: contlist){
            c.flightResponse__c = responseString;
        }


        //do DML inserts / update here 
        update contlist;


        
    }
/*
    public static String generatePayload(Contact singleContact){
        Id conid = singleContact.Id;
        Contact con = [SELECT Id, FirstName, LastName FROM Contact WHERE Id =: conid];
        String str = JSON.serializePretty(con);
        return str;
    }

    public static String doCallout(String str){
        HTTP h = new HTTP();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://1d2f1354-614b-45e7-9938-5eca16a793c1.mock.pstmn.io/api/flight');
        req.setMethod('GET');

        HttpResponse resp = h.send(req);
        return resp.getBody();
    }

    public static List<Contact> someCodeToValidate(String responseString, Contact singleContact){
        Id conid1 = singleContact.Id;
        List<Contact> ctList = [SELECT Id, 	flightResponse__c FROM Contact WHERE ID =:conid1];
        for(Contact c: ctList){
            c.flightResponse__c = responseString;
        }
        return ctList;
    }
}*/
}
