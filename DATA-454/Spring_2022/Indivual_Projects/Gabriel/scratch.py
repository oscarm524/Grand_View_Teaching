test['feature_1'] = np.where((test['manufacturerID'] == 113) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_2'] = np.where((test['manufacturerID'] == 20) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_3'] = np.where((test['manufacturerID'] == 49) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_4'] = np.where((test['manufacturerID'] == 21) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_5'] = np.where((test['manufacturerID'] == 24) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_6'] = np.where((test['manufacturerID'] == 54) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_7'] = np.where((test['manufacturerID'] == 25) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_8'] = np.where((test['manufacturerID'] == 45) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_9'] = np.where((test['manufacturerID'] == 18) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_10'] = np.where((test['manufacturerID'] == 97) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_11'] = np.where((test['manufacturerID'] == 55) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_12'] = np.where((test['manufacturerID'] == 26) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_13'] = np.where((test['manufacturerID'] == 53) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_14'] = np.where((test['manufacturerID'] == 56) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_15'] = np.where((test['manufacturerID'] == 44) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_16'] = np.where((test['manufacturerID'] == 75) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_17'] = np.where((test['manufacturerID'] == 64) & (test['salutation'] == 'Mrs'), 1, 0)
test['feature_18'] = np.where((test['manufacturerID'] == 16) & (test['salutation'] == 'Mrs'), 1, 0)


test.head()