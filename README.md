# 📉 Netflix Customer Churn Prediction Using Logistic Regression & Random Forest

This project builds a predictive model to identify customers likely to churn from Netflix services. It leverages logistic regression and random forest classification, with a focus on improving recall for at-risk users. Key predictors include customer tenure, service usage, and billing preferences.

---

## 🔍 Problem Statement

Customer retention is crucial for subscription-based services like Netflix. The goal of this project is to:

- Predict which customers are likely to cancel their subscriptions (churn)  
- Understand key factors driving churn  
- Use classification models to support proactive retention efforts

---

## 📦 Dataset

**Files Used**:
- `churn_data.csv`: Cleaned Netflix churn dataset  
- `churn_data_with_predictions.csv`: Dataset with churn predictions  
- Original source: Based on telecom churn dataset adapted for Netflix-like service characteristics

---

## 🛠️ Tools & Technologies

- **R**
- `ggplot2`, `dplyr` – EDA and visualization  
- `caTools` – data splitting  
- `caret` – performance evaluation  
- `randomForest` – ensemble modeling  
- Tableau – dashboard for churn analysis and metrics

---

## ⚙️ How It Works

### 1. Data Cleaning & Preprocessing
- Removed missing rows  
- Converted categorical variables into factors  
- Created `Tenure_Category` variable from numeric `Tenure`

### 2. Exploratory Data Analysis (EDA)
- Visualized churn distribution across:
  - Tenure
  - Gender
  - Monthly Charges
  - Contract types and services used

### 3. Model Building

**Logistic Regression**
- Used for baseline churn prediction  
- Tuned classification threshold from `0.5` to `0.3` to improve sensitivity  

**Random Forest**
- Used for improved accuracy and variable importance  
- Trained on full customer service profile  
- Predictions exported to CSV for Tableau integration

---

## 📈 Results

| Model              | Accuracy | Notes                        |
|--------------------|----------|------------------------------|
| Logistic Regression| ~79%     | Lower recall, interpretable  |
| Random Forest      | ~83%     | Higher accuracy, more robust |

**Threshold Adjustment:**  
- Default `0.5` changed to `0.3` to catch more churners

**Top Predictors:**
- Contract type
- Tech support availability
- Internet service type
- Monthly charges
- Tenure

---

## 📊 Output & Artifacts

- 📈 Confusion Matrices for both models  
- 📉 Churn probability distribution  
- 📊 Tableau dashboard using predicted results  
- 💾 CSV outputs with model predictions

---

## ✅ Business Value

- 📉 Reduces customer churn through early intervention  
- 🧠 Identifies high-risk customer segments  
- 📊 Empowers targeted marketing and retention strategies  
- 🧾 Helps optimize subscription offerings and support policies

---

## 🚀 Future Work

- 🔁 Use SMOTE to balance churn classes  
- 📦 Deploy the model in a Shiny or Streamlit dashboard  
- 🔍 Perform cohort analysis based on tenure and services  
- 🤖 Implement survival models or XGBoost for advanced churn prediction

---

## 👨‍💻 Author

**Nithin Sai Adru**  
📧 nithin.adru@email.ucr.edu

---
