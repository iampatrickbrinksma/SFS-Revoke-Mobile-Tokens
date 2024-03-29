# Revoke Mobile OAuth Tokens

When releasing a new version of your specific configurations and customizations for the Salesforce Field Service (SFS) mobile app as part of a release, the users need to clear the metadata cache and restart the app to retrieve the new version of the metadata and Lightning Web Components (LWC). But there is now to either force the users to do this, or tell the SFS mobile app to clear the metadata cache and restart. Another option is to logout and login again, but again there is not an easy way to force this. This repository contains code that forces the users to login again as it revokes the OAuth tokens for a specific (connected) app.

*IMPORTANT: Revoking a user's OAuth token will result in the user being logged out of the SFS mobile app. Any changes that have not been synchronized from the SFS mobile app are lost!*

# How Does It Work?

- Search all entries in the OAuthToken object for the given connected app
- Enqueue a queueable Apex class to delete the tokens one by one
- For each entry call the revoke token endpoint (```/services/oauth2/revoke?token=<DeleteToken>```)
- When a CallException is thrown enqueue the same queueable class again with the remaining tokens (chaining). This will typically happen when there are a lot of token (each token = 1 call), so the governor limits of maximum number of callouts or maximum aggregated duration of callouts will be violated.  

# Use

Deploy code to Salesforce sandbox environment first to perform proper testing!
Apex test class included so it can be deployed to production.

To revoke all tokens for a Connected App, run the following Anonymous Apex:
```
revokeTokenUtil.forceAppLogoutForAllUsers('Name Of The App');
```
Specific for the SFS mobile app for both iOS and Android:
```
revokeTokenUtil.forceAppLogoutForAllUsers('Salesforce Field Service for iOS');
revokeTokenUtil.forceAppLogoutForAllUsers('Salesforce Field Service for Android');
```
If you are using this in a Trial, Developer or Scratch org, use the following as it will run as a Apex Batch job:
```
revokeTokenUtil.forceAppLogoutForAllUsers('Name Of The App', true);
```


*IMPORTANT: Because chaining of a queueable Apex class is used and in trial, scratch orgs and demo orgs the maximum stack depth is 5 including the first enqueued instance, it will stop processing when it has reached the maximum stack depth.*

# Special Thanks

Thank you Leonardo Berardino for developing the Apex Mocking Framework: https://github.com/gscloudsolutions/GS-Apex-Mocking-Framework, so I could create Apex Test Class in an easy way.
