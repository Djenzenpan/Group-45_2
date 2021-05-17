import pandas as pd
import numpy as np

# Initialize size of data subsets
chunksize = (10 ** 4)
removables = ["click_bool","booking_bool","date_time", "position", "gross_bookings_usd"]

def add_features(filepath):

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)

    for i, chunk in enumerate(file):
        print(i)
        if i == 0:
            f = open("Data/train_with_price_rank.csv", "w")
            f.write("id,")
            for het in chunk.columns.to_list():
                f.write(het + ",")
            f.write("price_rank")
            f.close()

        #if i < 5:
        search_ids = chunk["srch_id"].to_list()
        prices = chunk["price_usd"].to_list()

        index = 0
        new_list = []
        for i in range(len(search_ids[:-1])):
            if i < index:
                pass
            else:
                price_storage = [float(prices[i])]
                current_search_id = search_ids[i]

                for j in range(len(search_ids[i:-1])):

                    if current_search_id == search_ids[j+i+1]:
                        price_storage.append(float(prices[j+i+1]))
                    else:
                        index = j + i + 1
                        break
                    index = j + i + 1
                temp_list = [None]*(len(price_storage))
                for cou in range(len(price_storage)):
                    current_best_index = price_storage.index(min(price_storage))
                    temp_list[current_best_index] = cou + 1
                    price_storage[current_best_index] = 5000000000000
                for rank in temp_list:
                    new_list.append(rank)
        while len(new_list) < len(search_ids):
            new_list.append(sum(new_list)/len(new_list))
        chunk["price_rank"] = new_list
        chunk.to_csv("Data/train_with_price_rank.csv", mode='a')
        #else:
            #break
    return filepath

def check(filepath):
    file = pd.read_csv(filepath, chunksize=chunksize)
    for i, chunk in enumerate(file):
        print(chunk["price_usd"])
        print(chunk["price_rank"])

if __name__ == "__main__":

    # Gradient booster
    new_df = add_features("Data/train.csv")

    check("Data/train_with_price_rank.csv")
