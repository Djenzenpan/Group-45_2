from datetime import datetime
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import make_pipeline
from sklearn import preprocessing
import numpy as np
from sklearn.model_selection import cross_val_score
from keras.layers import Input, Embedding, Flatten, Dot, Dense
from keras.models import Model
from keras.models import Sequential
from array import *

def get_year(x):
    if x is not None and type(x) is not float:
        try:
            return datetime.strptime(x, '%Y-%m-%d').year
        except ValueError:
            return datetime.strptime(x, '%Y-%m-%d %H:%M:%S').year
    else:
        return 2013
    pass


def get_month(x):
    if x is not None and type(x) is not float:
        try:
            return datetime.strptime(x, '%Y-%m-%d').month
        except:
            return datetime.strptime(x, '%Y-%m-%d %H:%M:%S').month
    else:
        return 1
    pass


def left_merge_dataset(left_dframe, right_dframe, merge_column):
    return pd.merge(left_dframe, right_dframe, on=merge_column, how='left')

def create_model(n_users,n_hotels):
    hotel_input = Input(shape=[1], name="Hotel-Input")
    hotel_embedding = Embedding(n_hotels + 1, 5, name="Hotel-Embedding")(hotel_input)
    hotel_vec = Flatten(name="Flatten-Hotels")(hotel_embedding)
    hotel1 = Dense(100,name='hDense1')(hotel_vec)
    hotel2 = Dense(100,name='hDense2')(hotel1)

    user_input = Input(shape=[1], name="User-Input")
    user_embedding = Embedding(n_users + 1, 5, name="User-Embedding")(user_input)
    user_vec = Flatten(name="Flatten-Users")(user_embedding)
    user1 = Dense(100, name='uDense1')(user_vec)
    user2 = Dense(100, name='uDense2')(user1)
    prod = Dot(name="Dot-Product", axes=1)([hotel2, user2])
    model = Model([user_input, hotel_input], prod)
    model.compile('adam', 'mean_squared_error')
    return model


def main():
    #Load files
    X_train = pd.read_csv('training_set_VU_DM.csv', sep=',')
    X_test = pd.read_csv('test_set_VU_DM.csv',sep=',')
    #X_test = pd.read_csv('test_set_small', sep=',')
    #X_train = pd.read_csv('training_set_small.csv', sep=',')
    #Deleted bad columns
    del X_train['gross_bookings_usd']
    #Remove columns with NULL (Not the right way right now, change later)
    cols = X_train.columns[X_train.isna().any()]
    X_train = X_train.drop(cols, axis=1)
    cols2 = X_test.columns[X_test.isna().any()]
    X_test = X_test.drop(cols2, axis=1)

    # for column in X_train:
    #     if X_train[column].isna().any() == True:
    #         X_train.update(X_train[column].fillna(value=X_train[column].mean(),inplace=True))

    #Split month from date_time and remove date_time
    X_train['date_time_month'] = pd.Series(X_train.date_time, index = X_train.index)
    X_train.date_time_month = X_train.date_time_month.apply(lambda x: get_month(x))
    X_test['date_time_month'] = pd.Series(X_test.date_time, index = X_test.index)
    X_test.date_time_month = X_test.date_time_month.apply(lambda x: get_month(x))
    del X_train['date_time']

    #Get max number of hotels and users(srch_id) for model
    n_hotels = X_train.prop_id.max()
    n_users = X_test.srch_id.max()

    #Create model
    model = create_model(n_users,n_hotels)

    #Only get rows where booking_bool = 1
    X_train = X_train.loc[X_train['booking_bool'] == 1]
    #Fit model on training data
    model.fit([X_train.srch_id,X_train.prop_id],X_train.booking_bool,epochs=10)
    user_list = []
    hotel_list = []

    #For every user(srch_id):
    for user in X_test.srch_id.unique():
        # 1. Get the rows with that srch_id
        userrow = X_test.loc[X_test['srch_id'] == user]
        # 2. Create an array with the prop_ids for that srch_id     array[(4234,3262,331,3242,636)]
        hotel_data = np.array(list(set(userrow.prop_id)))
        # 3. Create an array with the srch_id for every row         array[(1,1,1,1,1,1,1,1,1)] where 1 is srch_id
        user_input = np.array([user for i in range(len(hotel_data))])
        # 4. Predict which of the prop_ids is most likely to be booked
        predictions = model.predict([user_input, hotel_data])
        # 5. Get prop_id of hotel and add them to list with user (ranking from most likely to get booked to least likely)
        predictions = np.array([a[0] for a in predictions])
        recommended_hotel_id = (-predictions).argsort()
        for hotel_idx in recommended_hotel_id:
            user_list.append(user)
            hotel_list.append(X_test.loc[hotel_idx].prop_id)
    #Write lists to right format for Kaggle
    file = open("output.csv","w")
    file.write("srch_id,prop_id\n")
    for user,hotel in zip(user_list,hotel_list):
        file.write(str(user) + "," + str(hotel) + "\n")
    file.close()



if __name__ == '__main__':
    main()