public class HttpCalloutSampleReadOnly {
    public class MyReadOnlyException extends Exception {}

    // Pass in the endpoint to be used using the string url
    public String getCalloutResponseContents(String url) {
        
        // Get Read-only mode status
        ApplicationReadWriteMode mode = System.getApplicationReadWriteMode();
        String returnValue = '';
        
        if (mode == ApplicationReadWriteMode.READ_ONLY) {
            // Prevent the callout
            throw new MyReadOnlyException('Read-only mode. Skipping callouts!');
        } else if (mode == ApplicationReadWriteMode.DEFAULT) {
            // Instantiate a new http object
            Http h = new Http();
            
            // Instantiate a new HTTP request, specify the method (GET) 
            // as well as the endpoint.
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            
            // Send the request, and return a response
            HttpResponse res = h.send(req);
            returnValue = res.getBody();                        
        }
        return returnValue;
    }
}


/**
 * Your Salesforce org is in read-only mode during some Salesforce maintenance activities, 
 * such as planned site switches and instance refreshes. As part of Continuous Site Switching,
 *  your Salesforce org is switched to its ready site approximately once every six months. For more information about site switching, see Continuous Site Switching.
To test read-only mode in sandbox, contact Salesforce to enable the read-only mode test option. Once the test option is enabled, 


you can toggle read-only mode on and verify your apps.
 * 
 * 
 */