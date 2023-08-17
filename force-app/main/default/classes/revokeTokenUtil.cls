public with sharing class revokeTokenUtil {

    @TestVisible
    private static revokeTokenSelector revokeTokenSelector = new revokeTokenSelector();

    public static void forceAppLogoutForAllUsers(List<String> appNames){
        forceAppLogoutForAllUsers(appNames, false);
    }

    public static void forceAppLogoutForAllUsers(List<String> appNames, Boolean useBatch){
        revokeTokenQueueable q = new revokeTokenQueueable();
        if (useBatch){
            q.tokens = revokeTokenSelector.getTokens(appNames);
            System.enqueueJob(q);
        } else {
            revokeTokenBatch b = new revokeTokenBatch(appNames);
            Database.executeBatch(b, 1);            
        }
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