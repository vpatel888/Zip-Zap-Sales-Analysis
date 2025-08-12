# Zip-&-Zap-Sales-Analysis

### Table of Contents

- [Project Background](#project-background)
- [Data Source](#data-source)
- [Tools Used](#tools-used)
- [Summary of Insights](#summary-of-insights)
- [Dashboard](#dashboard)
- [Recommendations and Next Steps](#Recommendations-and-Next-Steps)

### Project Background 

Zip & Zap is a brick-and-mortar store that sells electronics, clothing, and beauty products. 

Insights and Recommendations are provided on the following North Star Metrics:

* **Monthly Revenue**: The amount of revenue made each month.

* **Monthly Transactions:** The number of transactions that occurred each month.

* **Average Transaction Value (ATV):** (Total Revenue/ Total Number of Transactions) each month. 

* **Average Basket Size (ABS):** (Total Number of Items Purchased/Total Number of Transactions) each month.

### Data Source
Retail Sales Dataset: The primary dataset used for this analysis is the " " file, containing synthetic data about sales from Zip & Zap.

### Tools Used
* **MySQL**

* **Tableau**

### Summary of Insights

#### **Monthly Revenue & Monthly Transactions:**
* May had the most total revenue; September had the least total revenue
* There appears to be peak in revenue during December, possibly due to the holiday season.
* The monthly revenue does appear to have a similar patterns to the monthly transactions graph. March and September had the lowest total revenue and the lowest total transactions, while May and October had the highes monthly revenue and highest total transactions. 


#### **Monthly Transactions:**
* May had the most total transactions; September had the least total transactions
* There appears to be peak in total transactions during December, possibly due to the holiday season.
* The monthly transactions does appear to have a similar patterns to the monthly revenue graph. March and September had the lowest total transactions and the lowest total revenue, while May and October had the highest monthly transactions and highest total revenue. 

#### **Monthly Average Transaction Value:**
* February had the highest ATV; September had the least ATV.

 #### **Monthly Average Basket Size:**
* March had the highest ABS; December had the lowest ABS.

Here's a snippet of code that pertains to the previous bullet:

```sql
  --On the dataset I used, 1 = Very Accurate and 5 = Very Inaccurate. For my analysis and tableau dashboard, I inverted the scale. But, that's why the scale appears flipped here in case if there's confusion over that. 

  -- Customers who find recommendations accurate and their add-to-cart behavior in percentage value:
  SELECT Add_to_Cart_Browsing, COUNT(Recommendation_Accuracy)/ (SELECT COUNT(Recommendation_Accuracy) FROM Amazon.`amazon customer behavior survey`WHERE Recommendation_Accuracy = 1 OR Recommendation_Accuracy = 2) * 100 AS Percentage
  FROM Amazon.`amazon customer behavior survey`
  WHERE Recommendation_Accuracy = 1 OR Recommendation_Accuracy = 2
  GROUP BY Add_to_Cart_Browsing;

  -- Customers who don't find recommendations accurate and their add-to-cart behavior in percentage value:
  SELECT Add_to_Cart_Browsing, COUNT(Recommendation_Accuracy)/ (SELECT COUNT(Recommendation_Accuracy) FROM Amazon.`amazon customer behavior survey`WHERE Recommendation_Accuracy = 4 OR Recommendation_Accuracy = 5) * 100 AS percentage
  FROM Amazon.`amazon customer behavior survey`
  WHERE Recommendation_Accuracy = 4 OR Recommendation_Accuracy = 5
  GROUP BY Add_to_Cart_Browsing;
```
  
#### **Customer Reviews Importance:**
##### **Score: 47.18% (percentage of customers who view reviews are important when making purchasing decisions)**
* Customers who explore multiple pages of search results value reviews higher in their purchasing decisions than those who only explore one page.
* Customers who value reviews higher in their purchasing decisions are more likely to add products to their cart while browsing the website than those who don't value reviews as much.

### Dashboard
Due to software issues, I was unable to implement the dropdown button that would switch between the graphs. Here's a description of the same issue that someone else had faced if you are interested: [List Parameter Issue](https://community.tableau.com/s/question/0D5cw00000KJXZXCA5/tableau-public-apple-silicon-crashing-when-creating-a-list-parameter). As an alternative, I implemented a text-box that would switch the charts when the user types a particular letter. The screenshot is below, but I highly recommend interacting with the dashboard's text box features so you can view all of the charts: 

[Tableau](https://public.tableau.com/views/AmazonConsumerBehavior/Dashboard2?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

<img width="2198" height="1698" alt="Dashboard 2 (2)" src="https://github.com/user-attachments/assets/67ccecba-25d2-488b-b17b-fe25fb4fe972" />

### Recommendations and Next Steps
* Investigate what issues unsatisifed customers have with Customer Service Responsiveness and implement changes based on frequent issues that are reported. 
* Continue to maintain competitive pricing and emphasize pricing in marketing strategy to push potential customers away from competitors
* To improve user engagement and overall satisfaction, enhance personalized recommendation systems by reviewing the customer data quality/volume that influences Machine Learning (ML) Models and also look into improving ML algorithms being used (collaborative-filtering, content-based filtering, hybrid models)
* Since trusting review accuracy is also likely to lead to more user engagement and overall satisfaction, look into improving AI systems that detect fake reviews as well as making sure that human moderators are equipped with the best tools to spot fake reviews 
