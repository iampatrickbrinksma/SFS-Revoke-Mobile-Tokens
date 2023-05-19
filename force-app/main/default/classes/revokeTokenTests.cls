@isTest
private with sharing class revokeTokenTests {

    @IsTest
    static void testRevokeTokens(){

        final String testAppName = 'testApp';

        revokeTokenCalloutMock revokeTokenCallout = new revokeTokenCalloutMock(
                                                        200,
                                                        'Complete',
                                                        '[{"status": 200}]',
                                                        null);

        Test.setMock(HttpCalloutMock.class, revokeTokenCallout);

        OAuthToken token1 = (OAuthToken) MockerUtils.updateObjectState(
            new OAuthToken(Id = MockerUtils.generateId(OAuthToken.SObjectType)),
            new Map<String, Object>{
                'UserId' => UserInfo.getUserId(),
                'AppName' => testAppName,
                'LastUsedDate' => System.now().addDays(-1),
                'DeleteToken' => 'afakedeletetokenfortestingpurpose'
            }
        );

        OAuthToken token2 = (OAuthToken) MockerUtils.updateObjectState(
            new OAuthToken(Id = MockerUtils.generateId(OAuthToken.SObjectType)),
            new Map<String, Object>{
                'UserId' => UserInfo.getUserId(),
                'AppName' => testAppName,
                'LastUsedDate' => System.now().addDays(-5),
                'DeleteToken' => 'anotherfakedeletetokenfortestingpurpose'
            }
        );        

        Mocker mocker = Mocker.startStubbing();

        revokeTokenSelector myMock = (revokeTokenSelector) mocker.mock(revokeTokenSelector.class);

        mocker.when(myMock.getTokens(testAppName))
                .thenReturn( new List<OauthToken>{token1, token2} );

        mocker.stopStubbing();

        Test.startTest();

        revokeTokenUtil.revokeTokenSelector = myMock;
        revokeTokenUtil.forceAppLogoutForAllUsers(testAppName);

        Test.stopTest();
        
    }

    @IsTest
    static void testRevokeTokensWithCalloutException(){

        final String testAppName = 'testApp';

        revokeTokenCalloutMock revokeTokenCallout = new revokeTokenCalloutMock(
                                                        500,
                                                        'Error',
                                                        '[{"status": 500}]',
                                                        null);

        Test.setMock(HttpCalloutMock.class, revokeTokenCallout);

        OAuthToken token1 = (OAuthToken) MockerUtils.updateObjectState(
            new OAuthToken(Id = MockerUtils.generateId(OAuthToken.SObjectType)),
            new Map<String, Object>{
                'UserId' => UserInfo.getUserId(),
                'AppName' => testAppName,
                'LastUsedDate' => System.now().addDays(-1),
                'DeleteToken' => 'afakedeletetokenfortestingpurpose'
            }
        );

        OAuthToken token2 = (OAuthToken) MockerUtils.updateObjectState(
            new OAuthToken(Id = MockerUtils.generateId(OAuthToken.SObjectType)),
            new Map<String, Object>{
                'UserId' => UserInfo.getUserId(),
                'AppName' => testAppName,
                'LastUsedDate' => System.now().addDays(-5),
                'DeleteToken' => 'anotherfakedeletetokenfortestingpurpose'
            }
        );        

        Mocker mocker = Mocker.startStubbing();

        revokeTokenSelector myMock = (revokeTokenSelector) mocker.mock(revokeTokenSelector.class);

        mocker.when(myMock.getTokens(testAppName))
                .thenReturn( new List<OauthToken>{token1, token2} );

        mocker.stopStubbing();

        Test.startTest();

        revokeTokenUtil.revokeTokenSelector = myMock;
        revokeTokenUtil.forceAppLogoutForAllUsers(testAppName);

        Test.stopTest();
        
    }

}