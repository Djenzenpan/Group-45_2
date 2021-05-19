import pandas as pd
import numpy as np

from sklearn.metrics import accuracy_score, ndcg_score
from sklearn.ensemble import GradientBoostingRegressor
from sklearn import preprocessing
import lightgbm as lgb
from tqdm import tqdm

# Initialize size of data subsets
chunksize = (10 ** 4)
removables = ["click_bool","booking_bool","date_time", "position", "gross_bookings_usd"]

def gradient_booster(filepath):

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)

    # Initialize model(s)
    #gbm = lgb.LGBMRegressor()
    gbm = GradientBoostingRegressor(max_depth=200)

    # Loop through file in size chunk
    for i, chunk in enumerate(file):

        y = chunk["booking_bool"]

        #min_max_scaler = preprocessing.MinMaxScaler()

        x = chunk.drop(removables, axis=1).fillna(-1)
        #x = min_max_scaler.fit_transform(x)

        if i == 0:
            gbm.fit(x,y)#,loss=ndcg_score(enumerate(y.to_list(), y))
        #else:
        break
            #pred_y = gbm.predict(x)

    return gbm



def make_prediction(model, filename):
    out_file = open("Results/output.csv", "w")
    out_file.write("srch_id,prop_id\n")
    file = pd.read_csv(filename, chunksize=chunksize)
    for chunk in tqdm(file):

        # Preprocess data
        x = chunk.drop("date_time", axis=1).fillna(-1)

        # Get necessary ids and predictions
        search_ids = chunk["srch_id"].to_list()
        prop_ids = chunk["prop_id"].to_list()
        pred_y = model.predict(x).tolist()
        index = 0
        for i in range(len(prop_ids[:-1])):
            if i < index:
                pass

            else:

                pred_storage = [pred_y[i]]
                prop_storage = [prop_ids[i]]
                current_search_id = search_ids[i]

                for j in range(len(prop_ids[i:-1])):

                    if current_search_id == search_ids[j+i+1]:
                        pred_storage.append(pred_y[j+i+1])
                        prop_storage.append(prop_ids[j+i+1])
                    else:
                        index = j + i + 1
                        break
                    index = j + i + 1
                while pred_storage:
                    current_best_index = pred_storage.index(max(pred_storage))
                    write_string = str(current_search_id) + "," + str(prop_storage[current_best_index]) + "\n"
                    pred_storage.pop(current_best_index)
                    prop_storage.pop(current_best_index)
                    out_file.write(write_string)
    out_file.close()
if __name__ == "__main__":

    # Gradient booster
    gbm = gradient_booster("Data/training_set_VU_DM.csv")

    # Final prediction
    make_prediction(gbm, "Data/test_set_VU_DM.csv")
