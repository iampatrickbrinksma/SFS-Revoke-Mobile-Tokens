@isTest
public with sharing class revokeTokenCalloutMock implements HttpCalloutMock {

    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Blob bodyAsBlob;
    protected Map<String, String> responseHeaders;    

    public revokeTokenCalloutMock(Integer code, String status, String body,
                                         Map<String, String> responseHeaders) {
        this.code = code;
        this.status = status;
        this.bodyAsString = body;
        this.responseHeaders = responseHeaders;
    }

    public HTTPResponse respond(HTTPRequest req) {
        if (status == 'Error'){
            throw new CalloutException();
        }

        HttpResponse resp = new HttpResponse();
        resp.setStatusCode(code);
        resp.setStatus(status);
        if (bodyAsBlob != null) {
            resp.setBodyAsBlob(bodyAsBlob);
        } else {
            resp.setBody(bodyAsString);
        }

        if (responseHeaders != null) {
             for (String key : responseHeaders.keySet()) {
            resp.setHeader(key, responseHeaders.get(key));
             }
        }
        return resp;
    }

}