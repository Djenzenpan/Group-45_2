import pandas as pd
import numpy as np

# Initialize size of subsets of data
chunksize = 10 ** 5

def open_chunks(filepath, column_name):

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)
    for thing in file:

        # Loops over columns in current chunk
        for something in thing:

            # Counts and prints number of NaNs in column and total column length
            null_counter = thing[something].notnull().sum()
            totalcounter = len(thing[something])
            print(something)
            print(totalcounter)
            print(null_counter)
            print("")

if __name__ == "__main__":
    open_chunks("Data/train.csv", 'comp8_rate_percent_diff')
