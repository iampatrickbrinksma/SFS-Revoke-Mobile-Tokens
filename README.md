# Revoke Mobile OAuth Tokens

When releasing the configurations and customizations for the Salesforce Field Service (SFS) mobile app as part of a release, the users need to clear the metadata and restart the app to retrieve the new version of the metadata and Lightning Web Components (LWC). Another option is to logout and login again. This repository contains code that forces the users to login again as it revokes the OAuth tokens.

*IMPORTANT: Revoking a user's OAuth token will result in the user being logged out of the SFS mobile app. Any changes that have not been synchronized from the SFS mobile app are lost!*

# Use

Deploy code to Salesforce sandbox environment first to perform proper testing!
Apex test class included so it can be deployed to production.
```
revokeTokenUtil.forceAppLogoutForAllUsers('Name Of The App');
```
# Special Thanks

Thank you Leonardo Berardino for developing the Apex Mocking Framework: https://github.com/gscloudsolutions/GS-Apex-Mocking-Framework, so I could create Apex Test Class in an easy way.
