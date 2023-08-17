public with sharing class revokeTokenBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    private String query = 'select Id, UserId, AppName, LastUsedDate, DeleteToken from OauthToken where AppName IN (\'';

    public revokeTokenBatch(List<String> appNames){
        this.query += String.join(appNames, '\',\'') + '\')';
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {        
        System.debug(query);
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> listOfObj) {
        OauthToken token = (OauthToken) listOfObj[0];
        revokeTokenUtil.revokeTokenForUser(token.DeleteToken);
    }

    public void finish(Database.BatchableContext BC) {}

}