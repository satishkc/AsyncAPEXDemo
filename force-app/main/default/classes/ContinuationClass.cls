/**
 * @description       : 
 * @author            : SKC
 * @group             : 
 * @last modified on  : 03-02-2021
 * @last modified by  : Satish Chandrashekar
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   03-02-2021   SKC                                  Initial Version
**/
public inherited sharing class ContinuationClass {

    // Callout endpoint as a named credential URL
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL =
        'https://1d2f1354-614b-45e7-9938-5eca16a793c1.mock.pstmn.io';

    // Action method
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startRequest() {
        // Create continuation. Argument is timeout in seconds.
        Continuation con = new Continuation(40);
        // Set callback method
        con.continuationMethod='processResponse';
        // Set state
        con.state='Hello, World!';
        // Create callout request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(LONG_RUNNING_SERVICE_URL);
        // Add callout request to continuation
        con.addHttpRequest(req);
        // Return the continuation
        return con;
    }

    // Callback method
    @AuraEnabled(cacheable=true)
    public static Object processResponse(List<String> labels, Object state) {
        // Get the response by using the unique label
        HttpResponse response = Continuation.getResponse(labels[0]);
        // Set the result variable
        String result = response.getBody();
        return result;
    }

} 
