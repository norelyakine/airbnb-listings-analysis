library(tidyverse)
library(lubridate)
library(ggplot2)

clean_airbnb <- clean_airbnb

# Nb of rows
n_rows <- nrow(clean_airbnb)
n_rows

# Count of missing values per column
missing_by_col <- colSums(is.na(clean_airbnb))
missing_by_col %>% sort(decreasing = TRUE)

# Nb of unique cities and property types
clean_airbnb %>%
  summarize(
    n_listings = n(),
    n_cities = n_distinct(City),
    n_property_types = n_distinct(Property_type)
  )

#<-- Summary Statistics for numeric columns -->
numeric_summary <- clean_airbnb %>%
  summarise(
    Listings =n(),
    Mean_price = mean(Final_price, na.rm =TRUE),
    Median_price = median(Final_price, na.rm =TRUE),
    Sd_price = sd(Final_price, na.rm =TRUE),
    Min_price = min(Final_price, na.rm =TRUE),
    Max_price = max(Final_price, na.rm =TRUE),
    
    Mean_rating = mean(Rating, na.rm =TRUE),
    Median_rating = median(Rating, na.rm =TRUE),
    Min_rating = min(Rating, na.rm =TRUE),
    Max_rating = max(Rating, na.rm =TRUE),
    
    Mean_duration = mean(Duration_days, na.rm =TRUE),
    Median_duration = median(Duration_days, na.rm =TRUE),
    Min_duration = min(Duration_days, na.rm =TRUE),
    Max_duration = max(Duration_days, na.rm =TRUE),
    
    Mean_reviews = mean(Nb_reviews, na.rm =TRUE),
    Median_reviews = median(Nb_reviews, na.rm =TRUE)
  )
numeric_summary


#<-- Outliers Check -->
qnt <- quantile(clean_airbnb$Final_price, probs = c(0.01,0.05,0.25,0.5,0.75,0.95,0.99), na.rm = TRUE)
qnt

#<-- Viz -->
#<-- Price Distribution -->
price_plot <- ggplot(clean_airbnb, aes(x = Final_price)) +
  geom_histogram(binwidth = 50, fill= "skyblue", color="black")+
  labs(title = "Airbnb Prices Distribution", x="Final Price ($)", y="Count")+
  theme_minimal()

ggsave("visuals/price_distribution.png", plot = price_plot, width = 8, height = 5)


#<-- Rating Distribution -->
rating_plot <- ggplot(clean_airbnb, aes(x= Rating))+
  geom_histogram(binwidth = 0.1, fill="lightgreen", color="black")+
  labs(title="Ratings Distribution", x="Rating", y="Count")+
  theme_minimal()

ggsave("visuals/rating_distribution.png", plot = rating_plot, width = 8, height = 5)

#<-- Duration Distribution -->
duration_plot <- ggplot(clean_airbnb, aes(x = Duration_days)) +
  geom_histogram(binwidth = 1, fill = "orange", color = "black") +
  labs(title = "Distribution of Booking Duration (days)", x = "Duration", y = "Count") +
  theme_minimal()
ggsave("visuals/duration_distribution.png", plot = duration_plot, width = 8, height = 5)


#<-- Property Types Distribution -->
property_plot <- ggplot(clean_airbnb, aes(x=Property_type))+
  geom_bar(fill="purple")+
  labs(title="Frequence of Property Types", x="Property Type", y="Count")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=45, hjust = 1))

ggsave("visuals/property_type_distribution.png", plot = property_plot, width = 8, height = 5)

#<-- Price by Property Type-->
price_by_property <- ggplot(clean_airbnb, aes(x = Property_type, y = Final_price)) +
  geom_boxplot(fill = "lightyellow") +
  labs(title = "Price by Property Type", x = "Property Type", y = "Final Price ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("visuals/price_by_property_distribution.png", plot = price_by_property, width = 8, height = 5)


#<-- Rating by City-->
rating_by_city <- ggplot(clean_airbnb, aes(x = City, y = Rating)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Rating by City", x = "City", y = "Rating") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("visuals/rating_by_city_distribution.png", plot = rating_by_city, width = 8, height = 5)


#<-- Average Price per Month-->
avg_price_per_month <- clean_airbnb %>%
  mutate(month = month(Start_date, label = TRUE)) %>%
  group_by(month) %>%
  summarise(avg_price = mean(Final_price, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = avg_price, group = 1)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Average Price per Month", x = "Month", y = "Average Price ($)") +
  theme_minimal()
ggsave("visuals/average_price_per_month.png", plot = avg_price_per_month, width = 8, height = 5)
