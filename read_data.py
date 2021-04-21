import pandas as pd
import numpy as np

# Initialize size of subsets of data
chunksize = 10 ** 5

def open_chunks(filepath, column_name):

    # Initialize dict for counting storage
    count_dict = {}

    # Splits dataset into chunks and loops through them
    file = pd.read_csv(filepath, chunksize=chunksize)
    for i, chunk in enumerate(file):

        # Loops over columns in current chunk
        for column in chunk:

            # Adds keys to dict if not yet there
            if column not in count_dict:
                count_dict[column] = {"Not-null": 0,
                                       "Total": 0}

            # Adds counts to proper place in dict
            else:
                count_dict[column]["Not-null"] += chunk[column].notnull().sum()
                count_dict[column]["Total"] += len(chunk[column])

        # Lets user know which chunk is currently being processes (total = 100)
        print("Chunk " + str(i))

    # Turns dict values to string for easy writing
    temp_string = ""
    for feature in count_dict:
        temp_string += str(feature)
        temp_string += ": Non-NaN=" + str(count_dict[feature]["Not-null"])
        temp_string += ". Total=" + str(count_dict[feature]["Total"]) + " \n"

    # Write counts string to file
    new_file = open("Results/counts.txt", "w")
    new_file.write(temp_string)
    new_file.close()


if __name__ == "__main__":
    open_chunks("Data/train.csv", 'comp8_rate_percent_diff')
