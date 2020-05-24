public class ContinuationSOAPController {
 
    AsyncSOAPStockQuoteService.GetStockQuoteResponse_elementFuture
           stockQuoteFuture;
    public String result {get;set;}

    // Action method
    public Continuation startRequest() {    
       Integer TIMEOUT_INT_SECS = 60;  
       Continuation cont = new Continuation(TIMEOUT_INT_SECS);
       cont.continuationMethod = 'processResponse';
       
       AsyncSOAPStockQuoteService.AsyncStockQuoteServiceSoap 
          stockQuoteService = 
            new AsyncSOAPStockQuoteService.AsyncStockQuoteServiceSoap();
           stockQuoteFuture = stockQuoteService.beginGetStockQuote(cont,'CRM');     
       return cont;   
    }    
    
    // Callback method
    public Object processResponse() {    
       result = stockQuoteFuture.getValue();
       // Return null to re-render the original Visualforce page
       return null; 
    }
}