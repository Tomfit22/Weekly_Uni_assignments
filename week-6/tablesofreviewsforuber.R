library(rvest)
library(dplyr)
library(lubridate)
library(stringr)
library(readr)

extract_rating <- function(rating_text) {
  as.integer(sub(".*?(\\d) out of 5.*", "\\1", rating_text))
}

all_reviews <- list()  # store each page

for (i in 1:5) {
  link <- paste0("https://www.trustpilot.com/review/ubereats.com?page=", i)
  page <- read_html(link)
  
  # Extract ratings
  ratings <- page %>%
    html_nodes("div.styles_reviewHeader__DzoAZ") %>%
    html_attr("data-service-review-rating") %>%
    as.integer()
  
  # Extract dates (adjust the node to match your "29 minutes ago" etc.)
  dates <- page %>%
    html_nodes("div.styles_datesWrapper__jszhG") %>%
    html_text(trim = TRUE)
  
  # Clean dates (example: days ago → Date)
  dates_clean <- sapply(dates, function(x) {
    x <- str_remove(x, "Updated ")
    if (str_detect(x, "day|hour|minute")) {
      # crude relative date parser (hours/minutes = today)
      days <- as.numeric(str_extract(x, "\\d+"))
      Sys.Date() - ifelse(is.na(days), 0, days)
    } else {
      mdy(x)
    }
  })
  
  all_reviews[[i]] <- tibble(
    rating = ratings,
    date_clean = as.Date(dates_clean)
  )
}

# Combine all pages
uber_df_all <- bind_rows(all_reviews)
uber_df_all

