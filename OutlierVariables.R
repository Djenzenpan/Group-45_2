## Create a boxplot of the Expedia variables that contain outliers

# Make a subset of original data-set specifically of columns containing outlying values
tr_outliers <- subset(tr, select = c(
  visitor_hist_adr_usd,
  prop_log_historical_price,
  price_usd,
  srch_length_of_stay,
  srch_booking_window,
  srch_adults_count,
  srch_children_count,
  srch_room_count,
  srch_query_affinity_score,
  orig_destination_distance,
  comp1_rate_percent_diff,
  comp2_rate_percent_diff,
  comp3_rate_percent_diff,
  comp4_rate_percent_diff,
  comp5_rate_percent_diff,
  comp6_rate_percent_diff,
  comp7_rate_percent_diff,
  comp8_rate_percent_diff,
  gross_bookings_usd
  ))

tr_outliers <- apply(tr_outliers, 2, as.numeric)

tr_outliers_scaled <- scale(tr_outliers) 

par(mar=c(12,4,4,2) + 0.1)
boxplot(tr_outliers_scaled, las=2, cex.names=0.8, ylab = "0 mean-centred values", main = "Normalised outlier-containing attributes")
