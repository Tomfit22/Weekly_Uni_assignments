
library(rvest)
library(tidyselect)
library(xml2)
library(tidyverse)
library(purrr)
library(readr)

link <- "http://books.toscrape.com/"
pagee <- read_html(link)
# call page to see the HTML structure.

titless <- pagee %>%
  html_elements("h3") %>%
  html_elements("a") %>% # Select all the links within those h3 tags
  html_attr("title") # Select the title attribute within the link tags

book_price <- pagee %>%
  html_elements(".price_color") %>%
  html_text2()

book_df <- tibble(
  title = titless,
  price = parse_number(book_price)
)

book_df

