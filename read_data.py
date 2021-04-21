import pandas as pd
import numpy as np

# Initialize size of subsets of data
chunksize = 10 ** 5

def open_chunks(filepath, column_name):

    the_dict = {}

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)
    for i, thing in enumerate(file):

        # Loops over columns in current chunk
        for something in thing:

            if something not in the_dict:
                the_dict[something] = {"Not-null": 0,
                                       "Total": 0}

            else:
                the_dict[something]["Not-null"] += thing[something].notnull().sum()
                the_dict[something]["Total"] += len(thing[something])

        print("Chunk " + str(i))

    temp_string = ""
    for feature in the_dict:
        temp_string += str(feature) + ": " + str(the_dict[feature]) + " \n"

    new_file = open("Results/counts.txt", "w")
    new_file.write(temp_string)
    new_file.close()


if __name__ == "__main__":
    open_chunks("Data/train.csv", 'comp8_rate_percent_diff')
