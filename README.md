# Predictive Modeling Projects

This repository contains a collection of R-based predictive modeling projects focusing on classification tasks. Each project demonstrates different approaches to feature engineering, model building, and evaluation.

## Repository Structure

```
data-analysis/
│
├── README.md
│
├── prediction1/
│   ├── README.md
│   └── prediction1.R
│
├── prediction2/
│   ├── README.md
│   └── prediction2.R
│ 
├── prediction3/
│   ├── README.md
│   └── prediction3.R
│
├── depression-analysis/
│   ├── README.md
│   └── hw1_code.R

```

## Projects Overview

### 1. Student Grade Prediction (prediction1)
A rule-based classification system for predicting student grades based on scores, participation rates, major, and seniority.

### 2. Marriage Outcome Prediction (prediction2)
A decision tree model for predicting marriage outcomes based on personality types, education, and age differences.

### 3. Hiring Decision Prediction (prediction3)
A classification model for predicting hiring decisions based on university, GPA, major, and geographic region.

### 4. Depression Analysis (hw1_code)
An exploratory data analysis of factors related to depression among students, including sleep patterns, academic pressure, and dietary habits.

## Getting Started

1. Clone this repository
2. Place necessary CSV files in the `data/` directory
3. Run individual project scripts from their respective directories

## Dependencies

- R (version 4.0 or higher recommended)
- Required R packages:
  - rpart
  - rpart.plot
  - ModelMetrics
  - devtools (for CrossValidation package)

