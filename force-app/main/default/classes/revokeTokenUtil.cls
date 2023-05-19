public with sharing class revokeTokenUtil {

    @TestVisible
    private static revokeTokenSelector revokeTokenSelector = new revokeTokenSelector();

    public static void forceAppLogoutForAllUsers(String appName){
        revokeTokenQueueable q = new revokeTokenQueueable();
        q.tokens = revokeTokenSelector.getTokens(appName);
        System.enqueueJob(q);
    }

    public static Boolean revokeTokenForUser(String deleteToken){
        String targetURL = URL.getOrgDomainUrl().toExternalForm() + '/services/oauth2/revoke?token=' + EncodingUtil.urlEncode(deleteToken, 'UTF-8');
        HttpRequest req = new HttpRequest();
        req.setEndpoint(targetURL);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        return res.getStatusCode() == 200 ? true : false;
    }

}