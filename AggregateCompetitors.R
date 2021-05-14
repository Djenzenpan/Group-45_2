### Aggregate 8 competitors columns values into 1 competitor

# create a smaller test set
#tr_10 <- subset(tr[1:10,])

# convert compX columns from type character to numeric
i <- c(28:51)
#tr_10[, i] <- apply(tr_10[, i], 2, as.numeric)  # convert compX columns from type character to numeric
tr_10[, i] <- apply(tr_10[, i], 2, as.numeric)  # convert compX columns from type character to numeric


# Load Training data-set (don't need this for now)
#tr <- read.csv("training_set_VU_DM.csv")

# Dimensions of original training data-set (don't need this for now)
#tr_row <- nrow(tr)  
#tr_col <- ncol(tr)


## Convert compX Rate
i <- 0
for (i in 1:10) {
  comp_rate <- -2
  
  if (is.na(tr_10$comp1_rate[i])) { 
      tr_10$comp1_rate[i] <- -2                 # Replace NULL with (invalid) dummy value
      tr_10$agg_comp_rate[i] <- comp_rate       # Write dummy value to new aggregated competitor column
  } else {
      comp_rate <- tr_10$comp1_rate[i]          # Save the current rate
      tr_10$agg_comp_rate[i] <- comp_rate       # Write current rate to aggregated comp
  }
  if (is.na(tr_10$comp2_rate[i])) { 
      tr_10$comp2_rate[i] <- -2          
      tr_10$agg_comp_rate[i] <- comp_rate       # Replace NULL with last saved rate
  } else {
      comp_rate <- tr_10$comp2_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp3_rate[i])) { 
      tr_10$comp3_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp3_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp4_rate[i])) { 
      tr_10$comp4_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp4_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp5_rate[i])) { 
      tr_10$comp5_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp5_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp6_rate[i])) { 
      tr_10$comp6_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp6_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp7_rate[i])) { 
      tr_10$comp7_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp7_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
  if (is.na(tr_10$comp8_rate[i])) { 
      tr_10$comp8_rate[i] <- -2   
      tr_10$agg_comp_rate[i] <- comp_rate  
  } else {
      comp_rate <- tr_10$comp8_rate[i]    
      tr_10$agg_comp_rate[i] <- comp_rate 
  }
}

## Convert compX inv value    
i <- 0
for (i in 1:10) {
  comp_inv <- -2

  if (is.na(tr_10$comp1_inv[i])) { 
    tr_10$comp1_inv[i] <- -2                # Replace NULL with (invalid) dummy value
    tr_10$agg_comp_inv[i] <- comp_inv       # Write dummy value to new aggregated competitor column
  } else {
    comp_inv <- tr_10$comp1_inv[i]          # Save the current inv value
    tr_10$agg_comp_inv[i] <- comp_inv       # Write current inv value to aggregated comp
  }
  if (is.na(tr_10$comp2_inv[i])) { 
    tr_10$comp2_inv[i] <- -2          
    tr_10$agg_comp_inv[i] <- comp_inv       # Replace NULL with last saved inv value
  } else {
    comp_inv <- tr_10$comp2_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp3_inv[i])) { 
    tr_10$comp3_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp3_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp4_inv[i])) { 
    tr_10$comp4_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp4_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp5_inv[i])) { 
    tr_10$comp5_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp5_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp6_inv[i])) { 
    tr_10$comp6_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp6_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp7_inv[i])) { 
    tr_10$comp7_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp7_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
  if (is.na(tr_10$comp8_inv[i])) { 
    tr_10$comp8_inv[i] <- -2   
    tr_10$agg_comp_inv[i] <- comp_inv  
  } else {
    comp_inv <- tr_10$comp8_inv[i]    
    tr_10$agg_comp_inv[i] <- comp_inv 
  }
}


## Convert compX Rate Percent Difference value
i <- 0
for (i in 1:10) {
  comp_diff <- -2
  
  if (is.na(tr_10$comp1_rate_percent_diff[i])) { 
    tr_10$comp1_rate_percent_diff[i] <- -2                 # Replace NULL with (invalid) dummy value
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff       # Write dummy value to new aggregated competitor column
  } else {
    comp_diff <- tr_10$comp1_rate_percent_diff[i]          # Save the current rate percent difference value
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff       # Write current rate percent difference value to aggregated comp
  }
  if (is.na(tr_10$comp2_rate_percent_diff[i])) { 
    tr_10$comp2_rate_percent_diff[i] <- -2          
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff       # Replace NULL with last saved rate percent difference value
  } else {
    comp_diff <- tr_10$comp2_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp3_rate_percent_diff[i])) { 
    tr_10$comp3_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp3_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp4_rate_percent_diff[i])) { 
    tr_10$comp4_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp4_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp5_rate_percent_diff[i])) { 
    tr_10$comp5_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp5_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp6_rate_percent_diff[i])) { 
    tr_10$comp6_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp6_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp7_rate_percent_diff[i])) { 
    tr_10$comp7_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp7_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  if (is.na(tr_10$comp8_rate_percent_diff[i])) { 
    tr_10$comp8_rate_percent_diff[i] <- -2   
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff  
  } else {
    comp_diff <- tr_10$comp8_rate_percent_diff[i]    
    tr_10$agg_comp_rate_percent_diff[i] <- comp_diff 
  }
  
}

# Export dataframe to csv (use this later)
#write.csv(tr_10, "~/Documents/DataMiningTechniques_X_400108/Assignment2/tr_10_test.csv")
