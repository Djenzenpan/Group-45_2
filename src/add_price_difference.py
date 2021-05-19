import pandas as pd
import numpy as np

# Initialize size of data subsets
chunksize = (10 ** 4)
removables = ["click_bool","booking_bool","date_time", "position", "gross_bookings_usd"]

def add_features(filepath):

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)

    for i, chunk in enumerate(file):

        prices = chunk["price_usd"].to_list()
        old_price = chunk["prop_log_historical_price"].to_list()
        days = chunk["srch_length_of_stay"].to_list()
        temp_list = []

        for j in range(len(prices)):
            if prices[j] != "price_usd":
                if old_price[j] != 0:
                    temp_list.append(float(prices[j]) - ((2**float(old_price[j]))*int(days[j])))
                else:
                    temp_list.append(0)
        chunk["price_diff_from_recent"] = temp_list

        if i == 0:
            chunk.to_csv("Data/test_with_price_dif.csv", header=chunk.columns, mode='w')
        else:
            chunk.columns = chunk.iloc[1]
            chunk = chunk[1:]
            chunk.to_csv("Data/test_with_price_dif.csv", header=None, mode='a')
        print(chunk)
    return filepath

def check(filepath):
    file = pd.read_csv(filepath, chunksize=chunksize)
    for i, chunk in enumerate(file):
        print(chunk["price_usd"])
        print(chunk["price_rank"])

if __name__ == "__main__":

    # Gradient booster
    new_df = add_features("Data/test_with_average_features.csv")
