public with sharing class revokeTokenQueueable implements Queueable, Database.AllowsCallouts {

    public List<OauthToken> tokens;

    public void execute(QueueableContext context){
        try {
            do{
                if (revokeTokenUtil.revokeTokenForUser(tokens[0].DeleteToken)){
                    tokens.remove(0);
                }
            } while (!tokens.isEmpty());
        } 
        catch (CalloutException e){
            // In case of a callout exception, queue the next job (chaining)
            // Callout exception can be related to governor limits like
            // the number of callouts per transaction (100) or the total
            // duration of all callouts during a transaction (120s)
            // If there is a problem server-side (e.g. status code 500)
            // this can be seen as a retry mechanism
            revokeTokenQueueable q = new revokeTokenQueueable();
            q.tokens = tokens;
            if (!Test.isRunningTest()) System.enqueueJob(q);
        }
    }
}