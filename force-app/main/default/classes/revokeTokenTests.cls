@isTest
private with sharing class revokeTokenTests {

    @isTest
    static void testRevokeSelector(){

        final String testAppName = 'testApp';
        revokeTokenSelector selector = new revokeTokenSelector();

        Test.startTest();

        List<OAuthToken> tokens = selector.getTokens(new List<String>{testAppName});

        Test.stopTest();

    }

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

        mocker.when(myMock.getTokens(new List<String>{testAppName}))
                .thenReturn( new List<OauthToken>{token1, token2} );

        mocker.stopStubbing();

        Test.startTest();

        revokeTokenUtil.revokeTokenSelector = myMock;
        revokeTokenUtil.forceAppLogoutForAllUsers(new List<String>{testAppName});

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

        mocker.when(myMock.getTokens(new List<String>{testAppName}))
                .thenReturn( new List<OauthToken>{token1, token2} );

        mocker.stopStubbing();

        Test.startTest();

        revokeTokenUtil.revokeTokenSelector = myMock;
        revokeTokenUtil.forceAppLogoutForAllUsers(new List<String>{testAppName});

        Test.stopTest();
        
    }

    @IsTest
    static void testRevokeTokenBatch(){

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

        Mocker mocker = Mocker.startStubbing();

        revokeTokenSelector myMock = (revokeTokenSelector) mocker.mock(revokeTokenSelector.class);

        mocker.when(myMock.getTokens(new List<String>{testAppName}))
                .thenReturn( new List<OauthToken>{token1} );

        mocker.stopStubbing();

        Test.startTest();

        revokeTokenBatch b = new revokeTokenBatch(new List<String>{testAppName});
        b.revokeTokenSelector = myMock;
        Database.executeBatch(b, 1);

        Test.stopTest();
        
    }    

}