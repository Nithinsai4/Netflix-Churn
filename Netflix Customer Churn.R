# Step 1: Install and load necessary libraries
install.packages("ggplot2")
install.packages("dplyr")
install.packages("caret")
install.packages("randomForest")
install.packages("caTools")

# Load libraries
library(ggplot2)
library(dplyr)
library(caret)
library(randomForest)
library(caTools)

# Step 2: Load the dataset from the provided link
churn_data <- read.csv("https://github.com/YBIFoundation/Dataset/raw/main/TelecomCustomerChurn.csv")

# Step 3: Inspect the data
summary(churn_data)
str(churn_data)

# Step 4: Data Cleaning
# Check for missing values
colSums(is.na(churn_data))

# Remove rows with missing values (optional: you could also impute missing values)
churn_data <- na.omit(churn_data)

# Convert categorical columns into factors
churn_data$Churn <- as.factor(churn_data$Churn) # Target variable
churn_data$SeniorCitizen <- as.factor(churn_data$SeniorCitizen) # SeniorCitizen as factor
churn_data$Gender <- as.factor(churn_data$Gender) # Gender as factor
churn_data$Partner <- as.factor(churn_data$Partner) # Partner as factor
churn_data$Dependents <- as.factor(churn_data$Dependents) # Dependents as factor
churn_data$PhoneService <- as.factor(churn_data$PhoneService) # PhoneService as factor
churn_data$MultipleLines <- as.factor(churn_data$MultipleLines) # MultipleLines as factor
churn_data$InternetService <- as.factor(churn_data$InternetService) # InternetService as factor
churn_data$OnlineSecurity <- as.factor(churn_data$OnlineSecurity) # OnlineSecurity as factor
churn_data$OnlineBackup <- as.factor(churn_data$OnlineBackup) # OnlineBackup as factor
churn_data$DeviceProtection <- as.factor(churn_data$DeviceProtection) # DeviceProtection as factor
churn_data$TechSupport <- as.factor(churn_data$TechSupport) # TechSupport as factor
churn_data$StreamingTV <- as.factor(churn_data$StreamingTV) # StreamingTV as factor
churn_data$StreamingMovies <- as.factor(churn_data$StreamingMovies) # StreamingMovies as factor
churn_data$Contract <- as.factor(churn_data$Contract) # Contract as factor
churn_data$PaperlessBilling <- as.factor(churn_data$PaperlessBilling) # PaperlessBilling as factor
churn_data$PaymentMethod <- as.factor(churn_data$PaymentMethod) # PaymentMethod as factor

# Step 5: Feature Engineering (Optional)
# Convert Tenure to numeric and create a new feature for tenure categories
churn_data$Tenure <- as.numeric(churn_data$Tenure)

# Create a new feature for tenure categories
churn_data$Tenure_Category <- cut(churn_data$Tenure, 
                                  breaks = c(0, 12, 24, 36, 48, 60), 
                                  labels = c("0-12", "12-24", "24-36", "36-48", "48-60"))

# Step 6: Exploratory Data Analysis (EDA)

# Churn distribution
ggplot(churn_data, aes(x = Churn)) + 
  geom_bar(fill = "skyblue") + 
  labs(title = "Churn Distribution", x = "Churn", y = "Count")

# Distribution of Tenure vs Churn
ggplot(churn_data, aes(x = Tenure, fill = Churn)) +
  geom_histogram(binwidth = 5, position = "dodge") + 
  labs(title = "Tenure vs Churn", x = "Tenure", y = "Count")

# Gender vs Churn
ggplot(churn_data, aes(x = Gender, fill = Churn)) +
  geom_bar(position = "dodge") + 
  labs(title = "Gender vs Churn", x = "Gender", y = "Count")

# MonthlyCharges vs Churn
ggplot(churn_data, aes(x = MonthlyCharges, fill = Churn)) +
  geom_histogram(binwidth = 10, position = "dodge") + 
  labs(title = "MonthlyCharges vs Churn", x = "Monthly Charges", y = "Count")

# Step 7: Split the Data into Training and Testing Sets
set.seed(123)  # Set seed for reproducibility
split <- sample.split(churn_data$Churn, SplitRatio = 0.7)
train_data <- subset(churn_data, split == TRUE)
test_data <- subset(churn_data, split == FALSE)

# Step 8: Logistic Regression Model
logit_model <- glm(Churn ~ SeniorCitizen + Gender + Partner + Dependents + Tenure + 
                     PhoneService + MultipleLines + InternetService + OnlineSecurity + 
                     OnlineBackup + DeviceProtection + TechSupport + StreamingTV + 
                     StreamingMovies + Contract + PaperlessBilling + PaymentMethod, 
                   data = train_data, family = binomial)

# Check model summary
summary(logit_model)

# Step 9: Make Predictions on the Test Data
logit_pred <- predict(logit_model, test_data, type = "response")

# Adjust the threshold to classify more customers as "Yes" (churn)
logit_pred_class <- ifelse(logit_pred > 0.3, 1, 0)  # Threshold is now 0.3 instead of 0.5
logit_pred_class <- as.factor(logit_pred_class)

# Step 10: Evaluate Model Performance
# Ensure factor levels match for confusionMatrix
logit_pred_class <- factor(logit_pred_class, levels = levels(test_data$Churn))

# Confusion Matrix
confusionMatrix(logit_pred_class, test_data$Churn)

# Step 11: Random Forest Model (Optional - For better performance)
rf_model <- randomForest(Churn ~ SeniorCitizen + Gender + Partner + Dependents + Tenure + 
                           PhoneService + MultipleLines + InternetService + OnlineSecurity + 
                           OnlineBackup + DeviceProtection + TechSupport + StreamingTV + 
                           StreamingMovies + Contract + PaperlessBilling + PaymentMethod, 
                         data = train_data, importance = TRUE)

# Make predictions with Random Forest
rf_pred <- predict(rf_model, test_data)

# Evaluate Random Forest Model
confusionMatrix(rf_pred, test_data$Churn)

write.csv(churn_data, "churn_data.csv", row.names = FALSE)
churn_data$rf_pred_class <- predict(rf_model, churn_data)
write.csv(churn_data, "churn_data_with_predictions.csv", row.names = FALSE)

