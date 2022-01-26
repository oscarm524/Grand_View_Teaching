test['feature_1'] = np.where((test['salutation'] == 0) & (test['w0'] > 3), 1, 0)
test['feature_2'] = np.where((test['salutation'] == 0) & (test['w1'] > 1), 1, 0)
test['feature_3'] = np.where((test['salutation'] == 0) & (test['w2'] > 0), 1, 0)
test['feature_4'] = np.where((test['salutation'] == 0) & (test['w5'] > 0), 1, 0)
test['feature_5'] = np.where((test['salutation'] == 0) & (test['w9'] > 0), 1, 0)

test['feature_6'] = np.where((test['salutation'] == 1) & (test['w0'] > 2), 1, 0)
test['feature_7'] = np.where((test['salutation'] == 1) & (test['w1'] > 0), 1, 0)
test['feature_8'] = np.where((test['salutation'] == 1) & (test['w2'] > 0), 1, 0)
test['feature_9'] = np.where((test['salutation'] == 1) & (test['w5'] > 0), 1, 0)
test['feature_10'] = np.where((test['salutation'] == 1) & (test['w9'] > 0), 1, 0)

test['feature_11'] = np.where((test['salutation'] == 2) & (test['w0'] > 1), 1, 0)
test['feature_12'] = np.where((test['salutation'] == 2) & (test['w9'] > 0), 1, 0)

test.head()