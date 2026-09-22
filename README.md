# 🎫 Customer Support Ticket Analytics

## 📌 Project Overview

**Customer Support Ticket Analytics** is an end-to-end data analytics project focused on understanding customer support operations and identifying persistent and emerging support issues.

The project analyzes customer support tickets across **products, ticket types, status, priority, channels, resolution time, and customer satisfaction**. It combines **Python/Pandas, Power Query, SQL Server, and Power BI** to transform raw support-ticket data into actionable business insights.

The analysis helps answer questions such as:

* Which products generate the most support tickets?
* What are the most common customer issues?
* Which categories are growing rapidly?
* Which issues require the longest resolution time?
* Which channels receive the most tickets?
* Where is unresolved workload concentrated?
* Which issue categories have lower customer satisfaction?
* Which product and issue combinations require further investigation?

> **Note:** Ticket categories represent observed issue classifications. They should not be interpreted as confirmed root causes without additional product, engineering, or operational data.

---

## 🎯 Business Problem

Support leadership needs to understand whether customer support issues are:

* **Persistent** — consistently generating high ticket volumes
* **Emerging** — rapidly increasing over time
* **Time-consuming** — requiring longer resolution times
* **Customer-impacting** — associated with lower satisfaction
* **Unresolved** — creating an increasing operational backlog

This project provides a data-driven framework for analyzing these patterns.

---

## 📊 Dataset

**Dataset:** Customer Support Ticket Dataset — Kaggle

The dataset contains information including:

* Ticket ID
* Customer details
* Product Purchased
* Date of Purchase
* Ticket Type
* Ticket Subject
* Ticket Description
* Ticket Status
* Resolution
* Ticket Priority
* Ticket Channel
* First Response Time
* Time to Resolution
* Customer Satisfaction Rating

---

## 🛠️ Tools & Technologies

| Tool            | Purpose                                    |
| --------------- | ------------------------------------------ |
| **Excel**       | Initial data inspection                    |
| **Power Query** | Data cleaning and transformation           |
| **Python**      | Data analysis and validation               |
| **Pandas**      | Data manipulation and statistical analysis |
| **SQL Server**  | Business analysis and querying             |
| **Power BI**    | Interactive dashboards and visualization   |

---

## 🔄 Project Workflow

```text
Kaggle Dataset
      ↓
Excel / Power Query
      ↓
Data Cleaning & Validation
      ↓
Python / Pandas
      ↓
SQL Server
      ↓
Business Analysis
      ↓
Power BI
      ↓
Executive & Diagnostic Dashboards
      ↓
Business Insights
```

---

## 🧹 Data Cleaning

The following data-quality checks were performed:

1. Validated **Ticket ID uniqueness**
2. Converted ticket dates to proper datetime format
3. Standardized ticket type, status, priority, channel, and product fields
4. Inspected missing resolution and satisfaction values
5. Converted resolution time into numeric duration
6. Checked for negative or invalid durations
7. Created month and week fields
8. Created SLA indicators where a documented SLA was available
9. Kept Open/Pending tickets separate from resolved-ticket metrics

---

## 🐍 Python / Pandas Analysis

Python was used for exploratory data analysis and data validation.

### Key tasks

* Dataset inspection
* Duplicate detection
* Missing-value analysis
* Data-type validation
* Categorical standardization
* Resolution-time analysis
* Ticket volume analysis
* Customer satisfaction analysis
* Monthly trend analysis

Example:

```python
df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(' ', '_')
)
```

---

## 🗄️ SQL Analysis

SQL Server was used to answer key business questions using:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `COUNT`
* `AVG`
* `ROUND`
* `CASE WHEN`
* CTEs
* Window functions
* `LAG`
* `PERCENTILE_CONT`

### Key SQL Questions

#### 1. Which products generate the highest number of tickets?

```sql
SELECT
    product_purchased,
    COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY product_purchased
ORDER BY total_tickets DESC;
```

#### 2. What are the most common ticket types?

```sql
SELECT
    ticket_type,
    COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_type
ORDER BY total_tickets DESC;
```

#### 3. How many tickets are Open, Pending, and Resolved?

```sql
SELECT
    ticket_status,
    COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_status;
```

#### 4. Which channels generate the most tickets?

```sql
SELECT
    ticket_channel,
    COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_channel
ORDER BY total_tickets DESC;
```

#### 5. Which products have the largest unresolved workload?

```sql
SELECT
    product_purchased,
    COUNT(ticket_id) AS unresolved_tickets
FROM support_ticket_RCA
WHERE ticket_status IN ('Open', 'Pending')
GROUP BY product_purchased
ORDER BY unresolved_tickets DESC;
```

---

## 📈 Power BI Dashboard

The Power BI report is divided into two main sections.

### Executive Overview

The executive dashboard includes:

* Total Tickets
* Resolved Tickets
* Open Tickets
* Pending Tickets
* Average Resolution Time
* Average Customer Satisfaction
* Monthly Ticket Trend
* Ticket Volume by Product
* Ticket Volume by Ticket Type
* Ticket Volume by Channel

### Diagnostic Analysis

The diagnostic dashboard focuses on:

* Ticket category volume
* Month-over-month growth
* Average resolution time
* Median resolution time
* Customer satisfaction by category
* Unresolved tickets by product
* Product × Ticket Type analysis
* Growth vs. resolution-time analysis

---

## 📊 Key KPIs

### Total Tickets

```DAX
Total Tickets =
COUNTROWS(support_ticket_RCA)
```

### Resolved Tickets

```DAX
Resolved Tickets =
CALCULATE(
    [Total Tickets],
    support_ticket_RCA[ticket_status] = "Resolved"
)
```

### Unresolved Tickets

```DAX
Unresolved Tickets =
CALCULATE(
    [Total Tickets],
    support_ticket_RCA[ticket_status]
        IN {"Open", "Pending"}
)
```

### Average Resolution Time

```DAX
Average Resolution Hours =
AVERAGE(
    support_ticket_RCA[resolution_hours]
)
```

### Average Satisfaction

```DAX
Average Satisfaction =
AVERAGE(
    support_ticket_RCA[customer_satisfaction_rating]
)
```

---

## 🔎 Root-Cause Analysis Framework

The project uses multiple indicators to identify areas requiring deeper investigation.

### Persistent Issues

```text
High Ticket Volume
        +
Stable Monthly Trend
        ↓
Potential Persistent Issue
```

### Emerging Issues

```text
Lower Current Volume
        +
Rapid Month-over-Month Growth
        ↓
Potential Emerging Issue
```

### High-Impact Issues

```text
High Volume
     +
High Growth
     +
Long Resolution Time
     +
Lower Satisfaction
     ↓
Priority for Further Investigation
```

These indicators identify **areas for investigation**, rather than proving the underlying technical root cause.

---

## 📁 Project Structure

```text
Customer-Support-Ticket-Analytics/
│
├── data/
│   └── customer_support_tickets.csv
│
├── python/
│   └── customer_support_analysis.ipynb
│
├── sql/
│   └── support_ticket_analysis.sql
│
├── powerbi/
│   └── support_ticket_dashboard.pbix
│
├── images/
│   └── dashboard.png
│
└── README.md
```

---

## 💡 Business Insights

The final analysis focuses on identifying:

* Products generating high support demand
* Frequently reported issue categories
* Monthly ticket-volume patterns
* Rapidly growing ticket categories
* Categories with long resolution times
* Channels generating significant workload
* Products with large unresolved workloads
* Issue categories associated with customer satisfaction differences
* Product and ticket-type combinations requiring deeper investigation

Actual numerical findings should be generated from the final cleaned dataset and Power BI report.

---

## ⚠️ Limitations

* Ticket type represents an **observed issue classification**, not necessarily the true root cause.
* SLA breach analysis requires a documented SLA threshold.
* Missing satisfaction ratings can affect satisfaction analysis.
* Unresolved tickets may not have valid resolution times.
* Percentage growth can be misleading for categories with very small baseline volumes.
* The dataset may not contain engineering, product telemetry, incident, or staffing information required for confirmed root-cause analysis.

---

## 🚀 Future Enhancements

Potential improvements include:

* Integrating product error logs
* Adding product release/deployment data
* Adding customer segmentation
* Adding support-agent workload data
* Implementing automated anomaly detection
* Building ticket-volume forecasting
* Adding real-time Power BI reporting
* Creating automated SLA alerts
* Performing NLP analysis on ticket descriptions
* Developing a predictive model for ticket escalation

---

## 📌 Conclusion

This project demonstrates an end-to-end **Customer Support Analytics** workflow using Python, Pandas, SQL Server, Power Query, and Power BI.

It transforms raw support-ticket data into structured analysis of **volume, trends, resolution performance, customer satisfaction, channels, unresolved workload, and product-category relationships**.

The project provides a practical framework for support teams to distinguish between recurring workload and potentially emerging issues and identify areas that require deeper investigation.

---

## 👨‍💻 Skills Demonstrated

**Data Analytics | Data Cleaning | Python | Pandas | SQL | SQL Server | Power Query | Power BI | DAX | Data Visualization | Exploratory Data Analysis | KPI Reporting | Business Analysis | Root-Cause Analysis**

---

## ⭐ Project Focus

**From raw customer support tickets → cleaned data → SQL analysis → Power BI dashboard → actionable business insights.**
