public with sharing class MultipleCalloutController {

    // Unique label for the first request
    public String requestLabel1;
    // Unique label for the second request
    public String requestLabel2;
    // Result of first callout
    public String result1 {get;set;}
   // Result of second callout
    public String result2 {get;set;}
    // Endpoints of long-running service
    private static final String LONG_RUNNING_SERVICE_URL1 = 
        '<Insert your first service URL>';
    private static final String LONG_RUNNING_SERVICE_URL2 = 
        '<Insert your second service URL>';
           
    // Action method
    public Object startRequestsInParallel() {
      // Create continuation with a timeout
      Continuation con = new Continuation(60);
      // Set callback method
      con.continuationMethod='processAllResponses';
      
      // Create first callout request
      HttpRequest req1 = new HttpRequest();
      req1.setMethod('GET');
      req1.setEndpoint(LONG_RUNNING_SERVICE_URL1);
      
      // Add first callout request to continuation
      this.requestLabel1 = con.addHttpRequest(req1);     
      
      // Create second callout request
      HttpRequest req2 = new HttpRequest();
      req2.setMethod('GET');
      req2.setEndpoint(LONG_RUNNING_SERVICE_URL2);
      
      // Add second callout request to continuation
      this.requestLabel2 = con.addHttpRequest(req2);     
      
      // Return the continuation
      return con;  
    }
    
    // Callback method.
    // Invoked only when responses of all callouts are returned.
    public Object processAllResponses() {   
      // Get the response of the first request
      HttpResponse response1 = Continuation.getResponse(this.requestLabel1);
      this.result1 = response1.getBody();

      // Get the response of the second request
      HttpResponse response2 = Continuation.getResponse(this.requestLabel2);
      this.result2 = response2.getBody();
                 
      // Return null to re-render the original Visualforce page
      return null;
    }
}