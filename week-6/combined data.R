uber_df_combined <- uber_df %>%
  mutate(date = uber_df_clean$date_clean) %>%
  rename(date_cleaned = date)
uber_df_combined