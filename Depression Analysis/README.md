# Depression Analysis Among Students

## Overview
This project conducts exploratory data analysis on factors related to depression among students. The analysis examines relationships between depression and various factors including sleep patterns, academic pressure, financial stress, dietary habits, GPA, and gender.

## Key Variables Analyzed
- Depression: Binary indicator of depression status
- Sleep Duration: Categories of sleep duration
- Academic Pressure: Numerical scale of academic pressure
- Financial Stress: Numerical scale of financial stress
- Dietary Habits: Categorical variable (Healthy, Moderate, Unhealthy, Others)
- CGPA: Cumulative grade point average
- Gender: Student gender

## Visualizations & Analyses

The project includes several visualizations to explore relationships:

1. **Mosaic Plot**: Sleep Duration vs. Depression
   - Examines relationship between sleep patterns and depression incidence

2. **Scatter Plot**: Academic Pressure vs. Financial Stress
   - Includes trend line to visualize correlation

3. **Bar Plot**: Depression Cases by Financial Stress Level
   - Compares depression incidence in high and low financial stress groups

4. **Bar Plot**: Depression Cases by Dietary Habits
   - Examines relationship between eating habits and depression

5. **Box Plot**: CGPA Distribution by Depression Status
   - Compares academic performance between depressed and non-depressed students

## Additional Statistical Analyses
- Average CGPA by sleep duration category
- Depression distribution by gender
- High achievers (CGPA ≥ 8.0) with depression by gender

## Files
- `HW1_code.R`: R script containing all analyses and visualizations
- Input files (required):
  - `depressdata.csv`: Dataset containing student information and depression indicators

## Usage
1. Place the required CSV file in the `data/` directory
2. Run the script:
```r
source("HW1_code.R")
```
3. Examine the generated plots and console output for insights

## Key Findings
- Students with less sleep show different depression patterns
- There appears to be a relationship between financial stress and depression
- Dietary habits show correlation with depression status
- Differences in CGPA exist between depressed and non-depressed students
- Gender differences exist in depression patterns, particularly among high achievers