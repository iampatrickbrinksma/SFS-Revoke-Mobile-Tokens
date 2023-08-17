public inherited sharing class revokeTokenSelector {

    public List<OAuthToken> getTokens(List<String> appNames){
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
                AppName in :appNames
        ];
    } 

}