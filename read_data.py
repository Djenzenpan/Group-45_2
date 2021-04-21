import pandas as pd
import numpy as np

# Initialize size of subsets of data
chunksize = 10 ** 5

def open_chunks(filepath, column_name):

    # Splits dataset into chunks and loops through them
    counter = 0
    totalcounter = 0
    file = pd.read_csv(filepath, chunksize=chunksize)
    for thing in file:

        # Counts and prints number of NaNs in column and total column length
        counter += thing[column_name].notnull().sum()
        totalcounter += len(thing[column_name])
        print(totalcounter)
        print(counter)
        print("")

if __name__ == "__main__":
    open_chunks("Data/train.csv", 'comp8_rate_percent_diff')
