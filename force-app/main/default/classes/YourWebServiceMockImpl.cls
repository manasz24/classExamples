global class YourWebServiceMockImpl implements WebServiceMock {
    global void doInvoke(
            Object stub,
            Object request,
            Map<String, Object> response,
            String endpoint,
            String soapAction,
            String requestName,
            String responseNS,
            String responseName,
            String responseType) {
 
         // Create response element from the autogenerated class.
         // Populate response element.
         // Add response element to the response parameter, as follows:
         response.put('response_x', responseElement); 
    }
 }