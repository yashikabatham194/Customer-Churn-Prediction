# Customer Churn Prediction Analysis

**Author:** Yashika Batham
**Program:** MBA – Business Analytics
**Tools:** R, Logistic Regression, Data Visualization

## 1. Project Overview

This project analyzes bank customer data to understand customer churn patterns and identify customers who may be likely to leave the bank.

The analysis uses exploratory data analysis, linear regression, multiple regression, and logistic regression to examine customer characteristics and predict churn.

## 2. Project Objectives

* Analyze customer characteristics and churn patterns.
* Compare churn rates across countries and customer groups.
* Build a logistic regression model to predict customer churn.
* Evaluate model performance using accuracy and recall.
* Identify customer groups that may benefit from retention strategies.

## 3. Dataset

* **Dataset:** Bank Customer Churn Prediction
* **Source:** [Kaggle – Bank Customer Churn Dataset](https://www.kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset)
* **Records:** 10,000 customers
* **Target variable:** `churn` (0 = stayed, 1 = churned)

The dataset contains customer information such as credit score, country, gender, age, tenure, account balance, number of products, credit card status, activity status, and estimated salary.

## 4. Tools and Techniques

* **R Programming:** Data analysis and statistical modelling
* **Data Cleaning:** Missing-value checks and categorical variable conversion
* **Exploratory Data Analysis:** Churn rate comparisons
* **Linear Regression:** Age vs. estimated salary
* **Multiple Regression:** Customer balance analysis
* **Logistic Regression:** Customer churn prediction
* **Model Evaluation:** 80:20 train-test split, confusion matrix, accuracy, and recall
* **Visualization:** Scatter plot, bar chart, and box plot

## 5. Key Findings

* Germany had the highest churn rate at approximately 32.4%, compared with 16.2% in France and 16.7% in Spain.
* Older and inactive customers showed a higher likelihood of churn in the analysis.
* The logistic regression model achieved approximately 82% accuracy and 25% recall at a probability threshold of 0.5.
* The low recall indicates that the model missed many customers who actually churned.

## 6. Project Visualizations

### Age vs. Estimated Salary

![Age vs Estimated Salary](https://github.com/yashikabatham194/Customer-Churn-Prediction/blob/main/age_vs_salary.png)

The analysis showed almost no linear relationship between age and estimated salary.

### Churn Rate by Country

![Churn Rate by Country](https://github.com/yashikabatham194/Customer-Churn-Prediction/blob/main/churn_by_country.png)

Germany recorded a substantially higher churn rate than France and Spain.

### Predicted Churn Probability

![Predicted Churn Probability](https://github.com/yashikabatham194/Customer-Churn-Prediction/blob/main/predicted_churn.png)

The chart compares predicted churn probabilities for customers who stayed and those who churned.

## 7. Conclusion

This project demonstrates how R and logistic regression can be used to analyze customer churn. The findings highlight differences in churn across countries and customer groups. Although the model achieved approximately 82% accuracy, its low recall suggests that further model improvement is needed to identify more customers at risk of leaving.

## 8. Files Included

* `Churn_Analysis.R` — R source code
* `Bank_Customer_Churn_Prediction.csv` — Dataset, subject to its licence
* `images/` — Project visualizations
* `Customer_Churn_Prediction.pptx` — Project presentation

## 9. Data Attribution

The dataset was obtained from Kaggle. Please refer to the [original dataset page](https://www.kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset) for creator attribution, licence terms, and permitted usage.

This project is intended for educational and portfolio purposes.

