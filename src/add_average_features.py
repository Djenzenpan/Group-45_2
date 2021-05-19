import pandas as pd
import numpy as np
import math

# Initialize size of data subsets
chunksize = (10 ** 4)
removables = ["click_bool","booking_bool","date_time", "position", "gross_bookings_usd"]

def add_features(filepath):

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)

    for i, chunk in enumerate(file):
        first = chunk["comp1_rate_percent_diff"].to_list()
        second = chunk["comp2_rate_percent_diff"].to_list()
        third = chunk["comp3_rate_percent_diff"].to_list()
        fourth = chunk["comp4_rate_percent_diff"].to_list()
        fifth = chunk["comp5_rate_percent_diff"].to_list()
        sixth = chunk["comp6_rate_percent_diff"].to_list()
        seventh = chunk["comp7_rate_percent_diff"].to_list()
        eigth = chunk["comp8_rate_percent_diff"].to_list()
        average = []

        for j in range(len(first)):
            temp_list = []
            for competitor in [first, second, third, fourth, fifth, sixth, seventh, eigth]:
                if isinstance(competitor[j], float):
                    if math.isnan(competitor[j]):
                        pass
                    else:
                        temp_list.append(competitor[j])
            if temp_list:
                average.append((sum(temp_list)/len(temp_list)))
            else:
                average.append(np.nan)


        chunk["average_rate_percent_diff"] = average
        if i == 0:
            chunk.to_csv("Data/test_with_average_features.csv", header=chunk.columns, mode='w')
        else:
            chunk.columns = chunk.iloc[1]
            chunk = chunk[1:]
            chunk[1:].to_csv("Data/test_with_average_features.csv", header=None, mode='a')
        print(chunk)
    return filepath

def check(filepath):
    file = pd.read_csv(filepath, chunksize=chunksize)
    for i, chunk in enumerate(file):
        print(chunk["price_usd"])
        print(chunk["price_rank"])

if __name__ == "__main__":

    # Gradient booster
    new_df = add_features("Data/test_with_price_rank.csv")
