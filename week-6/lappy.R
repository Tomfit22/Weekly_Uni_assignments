library(rvest)
library(dplyr)
library(stringr)
library(lubridate)

# Helper function to scrape one page
scrape_page <- function(page_number) {
  url <- paste0("https://www.trustpilot.com/review/ubereats.com?page=", page_number)
  page <- read_html(url)
  
  # Extract ratings
  ratings <- page %>%
    html_nodes("div[data-service-review-rating]") %>%
    html_attr("data-service-review-rating") %>%
    as.integer()
  
  # Extract raw date text
  relative_dates <- page %>%
    html_nodes("time") %>%
    html_attr("datetime") %>%
    as_datetime()
  
  file.rename("lappy.R", "lappy_new.R")
  
  
  tibble(
    rating = ratings,
    date_clean = relative_dates[5:24]
  )
}

# Vectorize with lapply over pages 1 to 5
all_reviews_list <- lapply(1:5, scrape_page)

# Combine all pages into one tibble
uber_df_all <- bind_rows(all_reviews_list)

# Inspect
uber_df_all
