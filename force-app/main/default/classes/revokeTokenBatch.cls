public with sharing class revokeTokenBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

    @TestVisible
    private revokeTokenSelector revokeTokenSelector = new revokeTokenSelector();

    private List<String> appNames;

    public revokeTokenBatch(List<String> appNames){
        this.appNames = appNames;
    }

    public System.Iterable<SObject> start(Database.BatchableContext BC) {        
        return revokeTokenSelector.getTokens(appNames);
    }

    public void execute(Database.BatchableContext BC, List<sObject> listOfObj) {
        OauthToken token = (OauthToken) listOfObj[0];
        revokeTokenUtil.revokeTokenForUser(token.DeleteToken);
    }

    public void finish(Database.BatchableContext BC) {}

}