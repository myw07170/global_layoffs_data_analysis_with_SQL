# Global Layoffs Data Analysis (2020-2023)

## Project Overview

This project performs a comprehensive analysis of layoff data from various companies worldwide between 2020 and 2023. It involves a two-stage process: first, cleaning a raw dataset to ensure its accuracy and consistency, and second, conducting an exploratory data analysis (EDA) to uncover key insights and trends. The entire process, from cleaning to analysis, is documented and executed using SQL.

The goal of this analysis is to understand the landscape of corporate layoffs, identifying which industries, countries, and companies were most affected, and tracking the trends over time.

- **Data Sourse**: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/tree/main
- **Tools Used**: MySQL

## Data Cleaning

[data cleaning.sql](data_cleaning.sql)

The initial phase of the project focused on cleaning the raw data from `layoffs.csv`. A staging table (`layoffs_staging`) was created to preserve the original data while performing cleaning operations. The cleaning process followed these sequential steps:

### Step 1: Removing Duplicates
Duplicates were identified based on a combination of critical columns: `company`, `industry`, `total_laid_off`, `date`, `stage`, `country`, and `funds_raised_millions`. A `ROW_NUMBER()` window function was used to assign a unique number to each row within a partition of identical records. Rows with a row number greater than 1 were considered duplicates and subsequently deleted.

### Step 2: Standardizing Data
Data consistency was improved by standardizing values across several columns:

- Company: Removed leading and trailing whitespace.
- Industry: Consolidated similar categories, such as merging 'Crypto Currency', 'CryptoCurrency' into a single 'Crypto' category.
- Country: Corrected typos and removed trailing characters (e.g., changing 'United States.' to 'United States').
- Date: Converted the `date` column from a text format (`MM/DD/YYYY`) to the standard SQL `DATE` format for easier querying.

### Step 3: Handling Null and Blank Values
To improve data quality, null and blank values were addressed:
- Blank entries in the `industry` column were converted to `NULL`.
- Missing `industry` values were populated by cross-referencing other records of the same company, where available.
- Rows where both `total_laid_off` and `percentage_laid_off` were `NULL` were deemed to have insufficient information for analysis and were therefore removed.

### Step 4: Removing Unnecessary Columns

The temporary `row_num` column, used earlier for identifying duplicates, was dropped from the final cleaned table to maintain a tidy schema.


## Exploratory Data Analysis (EDA)

[exploratory data analysis.sql](EDA_exploratory_data_analysis.sql)

With a clean and standardized dataset, an exploratory analysis was conducted to extract meaningful insights.

## Conclusion

This analysis provides a structured overview of the significant wave of layoffs that occurred between 2020 and 2023. The data indicates that the tech, consumer, and retail sectors were hit hardest, with a substantial concentration of job losses in the United States. The trend intensified significantly in 2022 and the first quarter of 2023, affecting both startups and major post-IPO corporations. This project demonstrates a complete data analysis workflow, from raw data cleaning to insightful exploration, all within a SQL environment.