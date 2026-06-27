# Walmart Sales Performance Analysis Report

> **A Comprehensive Data Analysis using Excel, SQL SSMS & Power BI**
> Covering **45 Stores · 143 Weeks · 2010 – 2012**

---

## 📊 Key Metrics at a Glance

| Total Revenue | Avg Weekly Sales | Total Stores | Weeks Tracked |
|---|---|---|---|
| **$6.74 Billion** | **$1,046,965** | **45** | **143** |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Data Description](#2-data-description)
3. [Methodology](#3-methodology)
4. [Analysis and Findings](#4-analysis-and-findings)
5. [Key Insights](#5-key-insights)
6. [Recommendations](#6-recommendations)
7. [Conclusion](#7-conclusion)

---

## 1. Introduction

### Company Profile: Walmart Inc.

Walmart Inc. is the world's largest retail corporation by revenue and one of the most recognized brands globally. Founded in 1962 by Sam Walton in Rogers, Arkansas, Walmart has grown from a single discount store into a multinational retail giant operating more than **10,500 stores and clubs across 24 countries** under 46 banners. Its global headquarters is located in Bentonville, Arkansas, United States.

Walmart's business model is centred on its iconic slogan, **'Everyday Low Prices' (EDLP)**, which drives customer loyalty by consistently offering goods at the lowest possible prices. The company operates across three primary segments: Walmart U.S., Walmart International, and Sam's Club. In fiscal year 2023, Walmart reported net revenues exceeding **$611 billion**, reinforcing its position as a dominant force in global retail.

As of 2024, Walmart employs approximately **2.1 million associates** in the United States alone, making it the largest private employer in the country. Its product range spans groceries, apparel, electronics, pharmaceuticals, financial services, and more — offering a one-stop-shop experience to millions of customers every week.

### Background & Purpose of the Study

This report presents a comprehensive data analysis of Walmart's weekly sales performance across **45 store locations** over a period spanning **February 2010 to October 2012**. The analysis was conducted to understand sales patterns, identify performance drivers, evaluate the impact of external economic factors, and generate actionable business insights.

The study was carried out as a multi-tool data analytics project using:
- **Microsoft Excel** — data cleaning and exploration
- **SQL Server Management Studio (SSMS)** — structured querying and aggregation
- **Power BI** — interactive dashboard visualization
- **Microsoft PowerPoint** — executive presentation

---

## 2. Data Description

### Dataset Overview

The dataset (`Walmart_Dataset.csv`) contains **6,435 rows** and **16 columns** representing weekly sales observations for 45 Walmart stores across a 143-week period from February 2010 to October 2012. The dataset is perfectly balanced — each of the 45 stores has an identical 143-week record, ensuring fair and unbiased comparisons between stores.

| Column | Data Type | Description |
|---|---|---|
| Row_ID | Integer | Unique identifier for each row |
| Store_ID | String | Walmart store identifier (e.g. WMT-001 to WMT-045) |
| Store | Integer | Store number (1–45) |
| Date | Date | Week ending date for the sales record |
| Weekly_Sales | Decimal | Total sales for the store in that week ($) |
| Holiday_Flag | Binary (0/1) | 1 = Holiday week, 0 = Non-holiday week |
| Holiday_Label | String | 'Holiday' or 'No Holiday' |
| Holiday_Name | String | Name of holiday (Non-Holiday, Super Bowl, Labour Day, Thanksgiving, Christmas) |
| Temperature | Decimal | Average temperature in the store region (°F) |
| Fuel_Price | Decimal | Regional fuel price ($ per gallon) |
| CPI | Decimal | Consumer Price Index — a measure of inflation |
| Unemployment | Decimal | Regional unemployment rate (%) |
| Year | Integer | Year extracted from Date (2010, 2011, 2012) |
| Month | Integer | Month number (1–12) |
| Month_Name | String | Full month name (January–December) |
| Quarter | Integer | Quarter (1–4) |

### Key Statistics

| Statistic | Value |
|---|---|
| **Total Observations (Rows)** | 6,435 |
| **Total Stores** | 45 |
| **Weeks Tracked per Store** | 143 |
| **Date Range** | February 2010 – October 2012 |
| **Minimum Weekly Sales** | $209,986.25 (Store 33, Dec 2010) |
| **Maximum Weekly Sales** | $3,818,686.45 (Store 14, Dec 2010) |
| **Mean Weekly Sales** | $1,046,964.88 |
| **Median Weekly Sales** | $960,746.00 |
| **Standard Deviation** | $564,366.60 |
| **Total Chain Revenue** | $6,737,218,987.11 |

### Data Quality

The dataset demonstrated excellent data quality with:
- No missing values
- No duplicate records
- No weeks returning zero or negative sales figures across any of the 143 weekly periods

All 45 stores maintained a consistent 143-week tracking period, confirming the dataset is perfectly balanced. Data cleaning and preparation was carried out in Microsoft Excel prior to SQL analysis.

---

## 3. Methodology

### Analytical Tools & Pipeline

This project followed a structured four-stage analytical pipeline:

| Stage | Tool | Activities |
|---|---|---|
| 1 | **Microsoft Excel** | Data importation, inspection, cleaning, formatting, calculation of derived columns (Year, Month, Quarter, Holiday_Label, Holiday_Name, Bucket columns), pivot table exploration and descriptive statistics |
| 2 | **SQL Server (SSMS)** | Structured analytical querying across 10 categories covering 60+ questions including aggregations, window functions (DENSE_RANK, LAG, FIRST_VALUE, OVER/PARTITION BY), conditional bucketing (CASE WHEN), subqueries, and Pareto cumulative analysis |
| 3 | **Power BI** | Interactive 9-page dashboard creation with DAX measures, calculated columns, KPI cards, bar/line/donut/scatter charts, slicers, conditional formatting, and cross-page filtering |
| 4 | **PowerPoint & Word** | Executive presentation (9 slides) and formal analytical report documenting all findings, insights and recommendations |

---

## 4. Analysis and Findings

### 4.1 Overall Business Performance

| Metric | Value | Notes |
|---|---|---|
| **Total Revenue** | $6.74 Billion | Across all 45 stores, 143 weeks |
| **Average Weekly Sales** | $1,046,965 | Chain-wide benchmark per week |
| **Total Rows (Observations)** | 6,435 | 143 weeks × 45 stores |
| **Number of Stores** | 45 | Perfectly balanced dataset |
| **Holiday Uplift** | 7.84% | Holiday vs non-holiday average |
| **Stores That Improved (YoY)** | 42 out of 45 | 2010 to 2011 |
| **Stores Peaking in Q1** | 0 | Universal — no store peaks in Q1 |

### 4.2 Store Performance & Ranking

Store performance varies dramatically across the 45 locations. The top-performing store (WMT-020) generated **$301M** in total sales while the weakest (WMT-033) generated only **$37.2M** — an **8x performance gap**.

#### Top 10 Stores by Total Sales

| Rank | Store ID | Total Sales | Avg Weekly Sales |
|---|---|---|---|
| 1 | **WMT-020** | $301,397,792 | $2,107,677 |
| 2 | **WMT-004** | $299,543,953 | $2,094,713 |
| 3 | **WMT-014** | $288,999,911 | $2,020,978 |
| 4 | **WMT-013** | $286,517,703 | $2,003,620 |
| 5 | **WMT-002** | $275,382,441 | $1,925,751 |
| 6 | **WMT-010** | $271,617,714 | $1,899,424 |
| 7 | **WMT-027** | $253,927,869 | $1,776,419 |
| 8 | **WMT-006** | $223,836,923 | $1,565,502 |
| 9 | **WMT-001** | $222,442,768 | $1,555,545 |
| 10 | **WMT-039** | $207,359,009 | $1,449,364 |

#### Store Performance Tier Classification

All 45 stores were classified into four performance tiers based on their average weekly sales:

| Tier | Store Count | Avg Weekly Sales Threshold | Example Stores |
|---|---|---|---|
| 🥇 **Platinum** | 12 | ≥ $1,395,901 | Stores 20, 4, 14, 13 |
| 🥈 **Gold** | 7 | ≥ $1,046,965 | Stores 1, 6, 27 |
| 🥉 **Silver** | 15 | ≥ $556,404 | Stores 7, 8, 12 |
| 🏅 **Bronze** | 11 | < $556,404 | Stores 33, 44, 5 |

### 4.3 Year-on-Year Performance (2010 vs 2011)

**42 out of 45 stores** improved their total sales from 2010 to 2011, with an overall chain-wide growth of **6.96%** (from $2.29B to $2.45B).

| Category | Store Count | Best Growth | Worst Decline |
|---|---|---|---|
| **Stores That Improved** | 42 / 45 (93%) | WMT-038 (+20.21%) | — |
| **Stores That Declined** | 3 / 45 (7%) | — | WMT-035 (−15.54%) |

> **Note:** The 2012 Q1–Q4 growth figure of −68.88% is explained by the dataset ending in September 2012, missing the entire Q4 holiday season.

### 4.4 Seasonal and Time Trends

| Quarter | Total Sales | Revenue Share | Avg Weekly Sales | Key Driver |
|---|---|---|---|---|
| **Q1** | $1.49 Billion | 22.18% | $1,006,136 | Post-holiday slowdown |
| **Q2** | $1.83 Billion | 27.11% | $1,040,806 | Spring/summer shopping |
| **Q3** | $1.84 Billion | 27.34% | $1,023,251 | Back-to-school, summer |
| **Q4** | $1.57 Billion | 23.37% | $1,128,774 | Thanksgiving, Christmas |

- **Best month:** July ($650M)
- **Weakest month:** January ($332M)
- **Universal finding:** Not a single store across all 45 locations ever peaked in Q1

### 4.5 Holiday Impact Analysis

#### Holiday vs Non-Holiday Sales

| Category | Avg Weekly Sales | Total Revenue | Revenue Share |
|---|---|---|---|
| **Holiday Weeks** | $1,122,888 | $505.3 Million | 7.5% |
| **Non-Holiday Weeks** | $1,041,256 | $6.23 Billion | 92.5% |

#### Performance by Holiday Type

| Holiday | Avg Weekly Sales | Week Count | vs Chain Avg |
|---|---|---|---|
| **Thanksgiving** | $1,471,273 | 90 | +40.5% ✅ |
| **Super Bowl** | $1,079,127 | 135 | +3.1% |
| **Labour Day** | $1,042,427 | 135 | −0.4% |
| **Non-Holiday** | $1,041,256 | 5,985 | Baseline |
| **Christmas** | $960,833 | 90 | −8.2% |

> 🔑 **Key Finding:** Thanksgiving consistently outperforms Christmas in **every single one of the 45 stores** without exception, driven by Black Friday shopping concentration.

### 4.6 External Factors & Sales Impact

#### Impact Ranking of External Factors

| Rank | Factor | Sales Range | Key Finding |
|---|---|---|---|
| **1st** | **Unemployment** | $338,720 | Low (3–6%): $1,181K vs Very High (10%+): $842K — **40% difference** |
| **2nd** | **Temperature** | $137,528 | Cool (33–60°F): $1,080K vs Hot (81–120°F): $942K |
| **3rd** | **CPI** | $85,486 | Low CPI (120–150): $1,083K vs Very High (200+): $997K |
| **4th** | **Fuel Price** | $23,450 | Minimal impact — customers trade down to Walmart when fuel rises |

---

## 5. Key Insights

### Insight 1: Thanksgiving, Not Christmas, is Walmart's Most Valuable Holiday

Thanksgiving week delivers an average of **$1,471,273** per store per week — **40.5% above** the chain average and **53% higher** than Christmas ($960,833). This is explained by the Black Friday phenomenon: consumers concentrate massive spending into the Thanksgiving/Black Friday window, while most Christmas gifts are already purchased in the weeks leading up to December 25th. This finding holds across **all 45 stores without a single exception**.

### Insight 2: Summer is Walmart's Peak Revenue Season

Contrary to conventional retail wisdom which emphasises Q4 holiday spending, **Q3 (July–September) is Walmart's strongest quarter** overall with $1.84 billion in total sales, edging out Q2 ($1.83B) and Q4 ($1.57B). July is the single best month at **$650M**, driven by back-to-school shopping and Fourth of July promotions. Q1 is universally the weakest quarter.

### Insight 3: Unemployment is the #1 External Risk Factor

Of the four external variables analyzed, unemployment exhibits the greatest influence on Walmart's weekly sales with a **$338,720 swing** between the best and worst unemployment buckets. Stores in low unemployment regions (3–6%) average **$1,180,603** per week compared to **$841,883** in very high unemployment regions (10%+) — a **40% difference**.

### Insight 4: The 4.5x Revenue Gap Between Top and Bottom Stores

The top 10 stores generate **4.5x more revenue** than the bottom 10 stores, despite comprising the same number of stores. The Pareto analysis confirms a modified 80/20 rule: **58% of stores generate 80% of revenue**, rather than the theoretical 20%.

### Insight 5: Store 20 Leads Overall but Store 14 Had the Best Single Week

- **Store 20** leads all-time total revenue at **$301.4M** (avg $2.1M/week)
- **Store 14** recorded the single highest weekly sales in the dataset at **$3,818,686.45** on Christmas Eve 2010 — nearly **3.6x the chain average**

> Peak performance is not a reliable indicator of overall strength.

### Insight 6: 93% of Stores Grew Year-on-Year from 2010 to 2011

42 out of 45 stores improved their total sales with chain-wide growth of **6.96%**. Only 3 stores declined:
- WMT-035 (−15.54%)
- WMT-036 (−10.31%)
- WMT-018 (−3.15%)

### Insight 7: Christmas Eve 2010 Was a Once-in-Dataset Outlier

**9 out of 10** of the highest single-week sales records across all stores occurred on **Christmas Eve 2010 (December 24, 2010)**. The only four instances where a store exceeded double its own weekly average all occurred on this same date.

### Insight 8: Low-Revenue Stores are the Most Consistent Performers

When measured by Coefficient of Variation (CV%), the most predictable stores are Bronze tier locations. **Store 37** has the lowest CV at just **4.21%** — however, this consistency reflects chronically low and stagnant sales rather than operational stability. High-performing Platinum stores show higher volatility because they benefit strongly from holiday spikes and seasonal peaks.

### Insight 9: Fuel Price Has Negligible Impact on Walmart Sales

Fuel price exhibits only a **$23,450 swing** between the best and worst buckets — less than **7% of the impact of unemployment**. This is consistent with the **'trade-down' theory**: rising fuel prices prompt consumers to reduce discretionary spending elsewhere but continue — and may even increase — their Walmart shopping as they seek value alternatives.

### Insight 10: 92.5% of Revenue is Generated in Non-Holiday Weeks

Despite the outsized attention paid to holiday periods, **92.5% of Walmart's $6.74B total revenue** was generated in regular non-holiday weeks. This reinforces the critical importance of optimising everyday operations, product availability, pricing and store experience.

---

## 6. Recommendations

### Recommendation 1: Prioritize Thanksgiving Over Christmas in Holiday Planning

Walmart should shift its peak holiday investment focus from Christmas to Thanksgiving/Black Friday. Resource allocation for inventory stocking, staffing, logistics, and promotional campaigns should be **disproportionately concentrated in the Thanksgiving period**, beginning 4–6 weeks in advance. The **40.5% uplift** above chain average makes this the single highest-return holiday event in the calendar.

### Recommendation 2: Implement a Summer Sales Strategy

Given that Q3 is the strongest revenue quarter and July is the best performing month, Walmart should develop a **dedicated summer strategy** that goes beyond back-to-school promotions. This should include summer-specific product promotions, outdoor and seasonal displays, and targeted marketing campaigns for July and August. Regional store managers should receive additional marketing budgets specifically for Q3 activities.

### Recommendation 3: Develop Unemployment-Sensitive Pricing and Inventory Strategies

Since unemployment is the strongest external predictor of weekly sales, Walmart should implement a **regional economic monitoring system** that adjusts store-level inventory mix, pricing promotions, and product assortment based on local unemployment conditions. Stores operating in high-unemployment regions (8–10%+) should prioritise essential goods, value-range products, and EDLP promotions.

### Recommendation 4: Establish a Performance Improvement Programme for Bronze Tier Stores

The **11 Bronze tier stores** (including Stores 33, 44, 5, 36 and 38) collectively generate only a fraction of what Platinum stores produce, yet consume comparable operational resources. A dedicated performance review programme should assess format suitability, catchment area demographics, product mix, staffing levels, and local competitive landscape.

### Recommendation 5: Replicate the Store 38 Turnaround Playbook

Store 38 achieved the strongest year-on-year growth of **+20.21%** from 2010 to 2011, despite being a Bronze tier store. An internal case study should be conducted to identify the specific operational, managerial, or market changes that drove this turnaround — and the findings codified into a replicable playbook for other underperforming stores.

### Recommendation 6: Protect and Invest in the 9 Elite Stores

Stores **1, 2, 4, 6, 10, 13, 14, 20 and 27** maintained top-10 rankings across all three years of data. These stores should receive priority access to:
- Flagship product launches
- Premium inventory allocations
- Experienced management teams
- Capital investment for store improvements

---

## 7. Conclusion

This comprehensive analysis of Walmart's sales performance data spanning **45 stores and 143 weeks** from February 2010 to October 2012 has yielded a rich set of findings:

- The chain generated **$6.74 billion** in total revenue with an average weekly sales rate of approximately **$1.05 million** per store
- **42 out of 45 stores** improved their sales year-on-year from 2010 to 2011 — pointing to strong growth momentum
- An **8x revenue gap** exists between top and bottom performers, exposing a dramatic performance hierarchy
- **Summer (particularly July)** emerges as Walmart's true peak revenue season, challenging common retail assumptions
- **Thanksgiving overwhelmingly outperforms Christmas** as a holiday sales driver, with the Black Friday effect amplifying Thanksgiving week sales to 40.5% above chain average
- **Unemployment** is the most significant macro-economic risk to Walmart's sales, with a 40% swing between low and very high unemployment environments
- Just **26 stores generate 80%** of total sales, confirming a concentrated Pareto distribution

---

> **Key Takeaways**
>
> - 📌 Unemployment is Walmart's #1 external risk factor
> - 📌 Thanksgiving beats Christmas in all 45 stores
> - 📌 Summer is the peak revenue season
> - 📌 The top 10 stores generate 4.5x more revenue than the bottom 10

---

*This analysis was carried out using a professional multi-tool pipeline — Microsoft Excel, SQL Server, Power BI, Microsoft PowerPoint, and a fo

