public inherited sharing class revokeTokenSelector {

    public List<OAuthToken> getTokens(String appName){
        return [
            select 
                Id,  
                UserId, 
                AppName, 
                LastUsedDate, 
                DeleteToken
            from 
                OauthToken 
            where 
                AppName =:appName
        ];
    } 

}