# Airbnb Data Analysis & Visualization
## Overview
This project analyzes Airbnb listing data to explore **price trends**, **ratings**, and **property distribution** across various cities.  
Using **R** for data cleaning and analysis, and **Tableau** for interactive visualization, this project showcases a full data analysis workflow — from raw CSVs to insights.

## Dataset
- **Source:** [Airbnb Listing Data for Data Science](https://www.kaggle.com/datasets/joyshil0599/airbnb-listing-data-for-data-science)  
- The dataset includes 3 CSV files.  
  This analysis focuses on **airbnb.csv**.  
- Key columns:
  - `Title`
  - `Price(in dollar)`
  - `Offer price(in dollar)`
  - `Review and rating`
  - `Number of bed`
  - `Date`
  - `Detail`

---

## Tools & Technologies
- **R**: `tidyverse`, `lubridate`, `ggplot2`  
- **Tableau**: for visualization and dashboard  
- **Git & GitHub**: version control  

---

## Steps & Methods

### Data Cleaning (R)
Key transformations performed:
- Extracted **rating** and **number of reviews** from the “Review and rating” column  
- Converted price strings (removed `$`, `,`) into numeric values  
- Extracted **start** and **end dates**, calculated **duration of stay**  
- Cleaned text in the “Detail” column  
- Extracted **property type**, **city**, and **country** from the “Title”  
- Created a **Final_price** column (using offer price if available)  
- Added a **Discount** indicator
- The cleaned dataset is exported as: cleaned_data/clean_airbnb.csv

- ---

### Data Analysis & Summary Stats
Computed:
- Total number of listings  
- Missing values per column  
- Summary statistics for:
  - Price (mean, median, sd, min, max)
  - Ratings
  - Duration
  - Reviews  
- Outlier detection using quantiles  

---

### Visualizations (R)
All plots saved in the `visuals/` folder.

| Visualization | Description | Output File |
|----------------|--------------|--------------|
| Price Distribution | Histogram of final prices | `price_distribution.png` |
| Ratings Distribution | Histogram of listing ratings | `rating_distribution.png` |
| Property Types | Frequency of each property type | `property_type_distribution.png` |
| Price by Property Type | Boxplot comparing prices | `price_by_property_distribution.png` |
| Rating by City | Boxplot showing ratings by city | `rating_by_city_distribution.png` |
| Average Price per Month | Line chart of monthly price trends | `average_price_per_month.png` |

---

### Tableau Dashboard
The cleaned dataset was imported into Tableau to create interactive visualizations.

**Visuals included:**
- **Map:** Concentration of listings in cities  
- **Bar Chart:** Popular Property Types - Top 10 Cities with the most Listings
- **Histogram:** Distribution of Ratings - Distribution of Prices
- **Scatter Plot:** Price vs Rating  
- **Line Chart:** Average price over months

🔗 [View Tableau Dashboard]([https://public.tableau.com/](https://public.tableau.com/shared/34XPJDRKG?:display_count=n&:origin=viz_share_link))  

---

## Key Insights
- Most listings are highly rated (4.5–5.0), showing general customer satisfaction.  
- Prices vary widely by property type — **villas and cabins** tend to be most expensive.  
- A few extreme prices (> $1000) create visible outliers.  
- Strong seasonal variation is visible in monthly price trends.

## Author 
Aya Nor Elyakine
