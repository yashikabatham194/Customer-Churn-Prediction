#------------------ Customer Churn Prediction ---------------
# By: Yashika Batham 

# INSTALL PACKAGES 
install.packages("dplyr")      # data manipulation
install.packages("ggplot2")    # charts
install.packages("pROC")       # AUC / ROC

# LOAD LIBRARIES
library(dplyr)
library(ggplot2)
library(pROC)

# Step 1: Import data
data <- read.csv("Bank_Customer_Churn_Prediction.csv")
head(data)
str(data)
summary(data)

# Step 2: Check missing values and churn rate
colSums(is.na(data))
table(data$churn)
prop.table(table(data$churn))      # about 20% of customers churn

# Step 3: Convert text columns to factors (not 1,2,3 numbers)
data$country <- factor(data$country)
data$gender  <- factor(data$gender)

# Step 4: Simple exploration - churn rate by group
tapply(data$churn, data$country, mean)          # churn rate by country
tapply(data$churn, data$gender, mean)           # churn rate by gender
tapply(data$churn, data$products_number, mean)  # churn rate by products
tapply(data$churn, data$active_member, mean)    # churn rate by activity

rates <- tapply(data$churn, data$country, mean)

png("churn_by_country.png")
bp <- barplot(rates, ylim = c(0, 0.4),
              main = "Churn Rate by Country", ylab = "Churn Rate",
              col = c("skyblue", "orange", "lightgreen"))
text(bp, rates, labels = paste0(round(rates * 100, 1), "%"), pos = 3)
dev.off()

# Step 5: Linear regression - Salary vs Age
linear_model <- lm(estimated_salary ~ age, data = data)
summary(linear_model)      # R-squared is almost 0, so age does not explain salary

predict(linear_model, data.frame(age = 40))     # predicted salary at age 40

r2 <- round(summary(linear_model)$r.squared, 5)

png("age_vs_salary.png")
plot(data$age, data$estimated_salary, col = "lightblue",
     main = "Age vs Estimated Salary", xlab = "Age", ylab = "Estimated Salary")
abline(linear_model, col = "red", lwd = 2)
legend("topright", legend = paste("R-squared =", r2), bty = "n")
dev.off()

# Step 6: Multiple regression - Balance
multi_model <- lm(balance ~ credit_score + age + estimated_salary, data = data)
summary(multi_model)       # R-squared is also very low

# Step 7: Split into training (80%) and testing (20%) data
set.seed(42)
rows  <- sample(nrow(data), 0.8 * nrow(data))
train <- data[rows, ]
test  <- data[-rows, ]

# Step 8: Logistic regression (correct model for churn = 0 or 1)
churn_model <- glm(churn ~ credit_score + country + gender + age + tenure +
                     balance + products_number + credit_card +
                     active_member + estimated_salary,
                   data = train, family = binomial)
summary(churn_model)

# Odds ratios: above 1 = more likely to churn, below 1 = less likely
exp(coef(churn_model))

# Step 9: Predict on test data
test$prob <- predict(churn_model, test, type = "response")
test$pred <- ifelse(test$prob >= 0.5, 1, 0)

# Step 10: Check accuracy
conf <- table(Actual = test$churn, Predicted = test$pred)
conf
accuracy <- sum(diag(conf)) / sum(conf)
accuracy

# Recall = how many real churners we caught
recall <- conf["1", "1"] / sum(conf["1", ])
recall

# Step 11: Save chart of predicted churn probability
med <- tapply(test$prob, test$churn, median)

png("predicted_churn.png")
boxplot(prob ~ churn, data = test,
        names = c("Stayed", "Churned"),
        main = "Predicted Churn Probability", ylab = "Probability",
        col = c("lightgreen", "salmon"))
text(1:2, med, labels = round(med, 2), pos = 3)
dev.off()
getwd()

# Step 12: ----------Conclusion-------------------- 
#We used exploratory analysis to find churn patterns, simple and 
#multiple linear regression to test salary and balance relationships, and 
#multiple logistic regression as the main churn model, 
#evaluated on a held-out test set using accuracy, recall and AUC.


# ------------ 1.Which country has the highest churn?-----------------------
# Germany has the highest churn rate (about 32%), compared with about 16%
# in France and Spain. German customers have roughly 2.2 times the odds of
# churning compared with French customers. Spain is not significantly
# different from France.
# -----------2. Which variables increase churn (odds ratio above 1)?--------
# Age (odds ratio about 1.08): each extra year raises the odds of churn
#   by about 8%, so older customers are more likely to leave.
# Germany (odds ratio about 2.15): customers in Germany churn more.
# Variables that reduce churn (odds ratio below 1):
# Active members (about 0.35): they are far less likely to churn.
# Male customers (about 0.59): female customers churn more.
# Credit score, tenure, salary and credit card were not significant.
# ----- 3. Accuracy is high but recall is low, so many churners are missed.-----
# Accuracy is about 82%, but recall is only about 25%, so the model misses
# most customers who actually churn. Accuracy looks high mainly because
# about 80% of customers stay. The boxplot also shows most churners get a
# predicted probability below 0.5.

# ---------------------4. Recommendation------------------------------
# The bank should focus retention offers on older, inactive customers,
# especially in Germany. The model can be improved by lowering the cutoff
# from 0.5 to 0.3 to catch more churners, accepting some extra false alarms.
S