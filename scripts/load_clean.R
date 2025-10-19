library(tidyverse)
library(lubridate)
 

airbnb <- read_csv("data/airnb.csv")

glimpse(airbnb)

summary(airbnb)

head(airbnb)      

# <-- Clean Review and Rating Column-->

airbnb <- airbnb %>%
  mutate(
    rating=as.numeric(str_extract(`Review and rating`, "^[0-9\\.]+")),
    nb_reviews=as.numeric(str_extract(`Review and rating`, "(?<=\\()\\d+(?=\\))"))
  )

# <-- Clean Number of Beds-->

airbnb <- airbnb %>%
  mutate(
    bed_count=as.numeric(str_extract(`Number of bed`, "[0-9]+"))
  )

# <-- Split Date Column-->
airbnb <- airbnb %>%
  mutate(
    start_str = str_extract(Date, "^[A-Za-z]{3} \\d+"),
    end_str = str_extract(Date, "(?<=-)\\s*[A-Za-z]{0,3}\\s*\\d+"),
    
    start_str = str_trim(start_str),
    end_str = str_trim(end_str),
    
    end_str = if_else(!str_detect(end_str, "[A-Za-z]"),
                      paste(str_extract(start_str, "^[A-Za-z]{3}"), end_str),
                      end_str),
    
    start_date = as.Date(paste(start_str, "2023"), format = "%b %d %Y"),
    end_date = as.Date(paste(end_str, "2023"), format = "%b %d %Y"),
    
    end_date = if_else(end_date < start_date,
                       end_date + months(1),
                       end_date),
    
    duration_days = as.numeric(end_date - start_date)
  )
# <-- Remove currency characters and commas-->
airbnb <- airbnb %>%
  mutate(`Price(in dollar)` = as.numeric(gsub("[\\$,]", "", `Price(in dollar)`)),
         `Offer price(in dollar)` = as.numeric(gsub("[\\$,]", "", `Offer price(in dollar)`)))

# <-- Discount Column-->
airbnb <- airbnb %>%
  mutate(
    discount= ifelse(!is.na(`Offer price(in dollar)`)&`Offer price(in dollar)`<`Price(in dollar)`, TRUE, FALSE)
  )

# <-- Final Price Column-->
airbnb <- airbnb %>%
  mutate(final_price = if_else(!is.na(`Offer price(in dollar)`),
                               `Offer price(in dollar)`,
                               `Price(in dollar)`))

# <-- Property type-->

airbnb <- airbnb %>%
  mutate(
    property_type=str_trim(str_extract(Title, "^(.*?) (?=in)"))
  )


# <-- Extract Full Location, City and Country-->
airbnb <- airbnb %>%
  mutate(
    location_full = ifelse(str_detect(Title, " in "),
                           str_trim(str_extract(Title, "(?<=in )(?!.* in ).*")),
                           NA_character_),
    location_full = str_replace(location_full, "^(in\\s+)", "")
  ) %>%

    mutate(
    comma_count = str_count(location_full, ","),
    city = case_when(
      comma_count >= 1 ~ str_trim(str_extract(location_full, "^[^,]+")),
      TRUE ~ str_trim(location_full)
    ),
    country = case_when(
      comma_count >= 1 ~ str_trim(str_extract(location_full, "[^,]+$")),
      TRUE ~ "US"
    )
  ) %>%
  select(-comma_count)

# <-- Clean details from unnecessary characters-->
airbnb <- airbnb %>%
  mutate(
    detail_clean=Detail %>%
      str_replace_all("[^\\w\\s.,!\\?\"'-]", "") %>%
      str_squish()
    )

# <-- Capitalize Columns Titles-->
airbnb <- airbnb %>%
  rename_with(~ str_replace(.x, "^.", toupper))



# <-- Cleaned Dataset-->
clean_airbnb <- airbnb %>%
  select(Property_type, City, Country, Detail_clean, Bed_count, Final_price,Discount, Final_price, Start_date, End_date, Duration_days, Nb_reviews, Rating, Location_full)
write.csv(clean_airbnb,"cleaned_data/clean_airbnb.csv")
