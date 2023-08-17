revokeTokenBatch b = new revokeTokenBatch(new List<String>{'Salesforce Field Service for Android', 'Salesforce Field Service for iOS'});
Database.executeBatch(b, 1);