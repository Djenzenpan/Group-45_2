### Aggregate 8 competitors columns values into 1 competitor (optimised)

# Load original Training data-set
tr <- read.csv("training_set_VU_DM.csv")

start_time <- Sys.time()
start_time

# Remove all columns other than for the competitor variables
print("Creating subset of competitor variables only\n")
tr_comp <- tr[, 28:51]


end_time <- Sys.time()
duration_subset <- "Duration after creating competitor subset:\n"
cat(duration_subset, end_time - start_time)


# convert compX columns from type character to numeric
print("Converting competitor columns into type numeric")
i <- c(1:24)
tr_comp[, i] <- apply(tr_comp[, i], 2, as.numeric)  # convert compX columns from type character to numeric


# Dimensions of competitor subset
tr_comp_row <- nrow(tr_comp)  


## Convert compX Rate
print("Starting compX Rate")

i <- 0
for (i in 1:tr_comp_row) {    
  comp_rate <- -2    # dummy value for NA
  
  if (is.na(tr_comp$comp1_rate[i])) { 
      print("NA ")     
  } else {
      comp_rate <- tr_comp$comp1_rate[i]
  }
  if (is.na(tr_comp$comp2_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp2_rate[i]
  }
  if (is.na(tr_comp$comp3_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp3_rate[i]
  }
  if (is.na(tr_comp$comp4_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp4_rate[i]
  }
  if (is.na(tr_comp$comp5_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp5_rate[i]
  }
  if (is.na(tr_comp$comp6_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp6_rate[i]
  }
  if (is.na(tr_comp$comp7_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp7_rate[i]
  }
  if (is.na(tr_comp$comp8_rate[i])) {
      print("NA ")
  } else {
      comp_rate <- tr_comp$comp8_rate[i]
  }
  
  tr_comp$agg_comp_rate[i] <- comp_rate    
  
  iterations <- "iterations of compX_rate completed!\n"
  cat(i, iterations)
  
}

end_time <- Sys.time()
duration_rate <- "Duration after compX_rate:\n"
cat(duration_rate, end_time - start_time)




## Convert compX inv value   
print("Starting compX inv")

i <- 0
for (i in 1:tr_comp_row) {    
  comp_rate <- -2    # dummy value for NA
  
  if (is.na(tr_comp$comp1_inv[i])) { 
    print("NA ")     
  } else {
    comp_rate <- tr_comp$comp1_inv[i]
  }
  if (is.na(tr_comp$comp2_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp2_inv[i]
  }
  if (is.na(tr_comp$comp3_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp3_inv[i]
  }
  if (is.na(tr_comp$comp4_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp4_inv[i]
  }
  if (is.na(tr_comp$comp5_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp5_inv[i]
  }
  if (is.na(tr_comp$comp6_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp6_inv[i]
  }
  if (is.na(tr_comp$comp7_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp7_inv[i]
  }
  if (is.na(tr_comp$comp8_inv[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp8_inv[i]
  }
  
  tr_comp$agg_comp_inv[i] <- comp_rate    
  
  iterations <- "iterations of compX_inv completed!\n"
  cat(i, iterations)
}

end_time <- Sys.time()
duration_inv <- "Duration after compX_inv:\n"
cat(duration_inv, end_time - start_time)



## Convert compX Rate Percent Difference value
print("Starting compX Rate Percent Difference")

i <- 0
for (i in 1:tr_comp_row) {    
  comp_rate <- -2    # dummy value for NA
  
  if (is.na(tr_comp$comp1_rate_percent_diff[i])) { 
    print("NA ")     
  } else {
    comp_rate <- tr_comp$comp1_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp2_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp2_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp3_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp3_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp4_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp4_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp5_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp5_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp6_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp6_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp7_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp7_rate_percent_diff[i]
  }
  if (is.na(tr_comp$comp8_rate_percent_diff[i])) {
    print("NA ")
  } else {
    comp_rate <- tr_comp$comp8_rate_percent_diff[i]
  }
  
  tr_comp$agg_comp_rate_percent_diff[i] <- comp_rate    
  
  iterations <- "iterations of compX_rate_percent_diff completed!\n"
  cat(i, iterations)
}

end_time <- Sys.time()
duration_rpc <- "Duration after compX_rate_percent_diff:\n"
cat(duration_rpc, end_time - start_time)


## Export data-frame to csv 
print("Writing to csv")
write.csv(tr_comp[, 25:27], "~/Documents/SarahUniStuff_temp/tr_aggregatedComp.csv")

end_time <- Sys.time()
end_time - start_time
