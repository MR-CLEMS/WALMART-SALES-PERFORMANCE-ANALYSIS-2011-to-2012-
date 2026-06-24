use Project
go
---Q1 what is the total revenue genefrated from the 45 stores?
select * from Walmart_Datasett
select format(sum(weekly_Sales), 'N2') as Total_Revenue
from Walmart_Datasett

---Q2 What is the average sales from the 45 stores for the year under review?
select format (avg(weekly_sales), 'N2') as Avg_weekly_sales
from Walmart_Datasett

---Q3 what are the top ten highest single week sales ever recorded?

SELECT TOP 10
    Store_ID, Store, Date, Weekly_Sales
FROM Walmart_datasett
ORDER BY Weekly_Sales DESC;
---Q4 What are the top ten stores with the lowest sales ever?
SELECT TOP 10
    Store_ID, Store,
    SUM(Weekly_Sales) AS Total_Sales, AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store
ORDER BY Total_Sales ASC;
--- Q5 What are the total number of week tracked per store?
select Store_ID Store,
count (*) as Total_Weeks_Tracked
from Walmart_Datasett
Group by Store_ID, Store
Order by Store asc;
---6 What are top 10 stores by total sales?
SELECT TOP 10
Store_ID, Store,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store
ORDER BY Total_Sales DESC;
---7 What are the bottom 10 stores by total sales
SELECT TOP 10
Store_ID, Store,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store
ORDER BY Total_Sales ASC;
---8 Waht is the average weekly sales per store, ranked highest to lowest
SELECT top 10
Store_ID, Store,
AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store
ORDER BY Avg_Weekly_Sales DESC;
--- 9 What are the stores that performed below the chain average?
SELECT
Store_ID,
Store,
AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store
HAVING AVG(Weekly_Sales) > (SELECT AVG(Weekly_Sales) FROM Walmart_datasett)
ORDER BY Avg_Weekly_Sales DESC;
--- 10 What are sales growth per store, first recorded against last recorded week (top 5)
SELECT TOP 5
Store_ID, Store,First_Sales, Last_Sales,
ROUND(((Last_Sales - First_Sales) / First_Sales) * 100, 2) AS Growth_Pct
FROM (
SELECT
Store_ID, Store,
FIRST_VALUE(Weekly_Sales) OVER (PARTITION BY Store ORDER BY Date ASC) AS First_Sales,
FIRST_VALUE(Weekly_Sales) OVER (PARTITION BY Store ORDER BY Date DESC) AS Last_Sales
FROM Walmart_datasett
) AS Sales_Bounds
GROUP BY Store_ID, Store, First_Sales, Last_Sales
ORDER BY Growth_Pct DESC;

--- 11 What are the total sales made by each year?
SELECT
Year,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Year
ORDER BY Year ASC;
---12 What are the total sales made by each quarter of the year?
SELECT
Year, Quarter,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Year, Quarter
ORDER BY Year ASC, Quarter ASC;
--- 13 What are the monthly sales per each year?
SELECT
Month,
Month_Name,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Month, Month_Name
ORDER BY Month ASC;
--- 14 What are the average weekly sales per quarter?
SELECT
Quarter,
AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM Walmart_datasett
GROUP BY Quarter
ORDER BY Quarter ASC;
---15 What is the Year over Year growth?
SELECT
Year,
SUM(Weekly_Sales) AS Total_Sales,
LAG(SUM(Weekly_Sales)) OVER (ORDER BY Year) AS Prev_Year_Sales,
ROUND(
(SUM(Weekly_Sales) - LAG(SUM(Weekly_Sales)) OVER (ORDER BY Year)) /
LAG(SUM(Weekly_Sales)) OVER (ORDER BY Year) * 100, 2
) AS YoY_Growth_Pct
FROM Walmart_datasett
GROUP BY Year
ORDER BY Year ASC;
---16 What are the total sales made during holdidays as against non-holidays?
SELECT
Holiday_Flag, Holiday_Label,
SUM(Weekly_Sales)   AS Total_Sales,
AVG(Weekly_Sales)   AS Avg_Weekly_Sales,
COUNT(*)            AS Total_Weeks
FROM Walmart_datasett
GROUP BY Holiday_Flag, Holiday_Label
ORDER BY Holiday_Flag DESC;
---18 What is the total and average sales per each holiday?
SELECT
Holiday_Name,
SUM(Weekly_Sales)   AS Total_Sales,
AVG(Weekly_Sales)   AS Avg_Weekly_Sales,
COUNT(*)            AS Week_Count
FROM Walmart_datasett
GROUP BY Holiday_Name
ORDER BY Avg_Weekly_Sales DESC;
---19 What is the overall holiday sales uplift percentage vs non holiday weeks?
SELECT
ROUND(
(AVG(CASE WHEN Holiday_Flag = 1 THEN Weekly_Sales END) -
AVG(CASE WHEN Holiday_Flag = 0 THEN Weekly_Sales END)) /
AVG(CASE WHEN Holiday_Flag = 0 THEN Weekly_Sales END) * 100, 2
) AS Holiday_Uplift_Pct
FROM Walmart_datasett;
---20 What is the average sales per store (holiday vs non-holiday)?
SELECT
Store_ID,Store,Holiday_Label,
AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store, Holiday_Label
ORDER BY Store ASC, Holiday_Label DESC;
---21 What are the top ten mostly impacted by holiday weeks?
SELECT TOP 10
h.Store_ID,
h.Store,
ROUND(h.Holiday_Avg, 2)     AS Holiday_Avg,
ROUND(n.NonHoliday_Avg, 2)  AS NonHoliday_Avg,
ROUND(((h.Holiday_Avg - n.NonHoliday_Avg) / n.NonHoliday_Avg) * 100, 2) AS Uplift_Pct
FROM (
SELECT Store_ID, Store, AVG(Weekly_Sales) AS Holiday_Avg
FROM Walmart_datasett WHERE Holiday_Flag = 1
GROUP BY Store_ID, Store
) h
JOIN (
SELECT Store_ID, Store, AVG(Weekly_Sales) AS NonHoliday_Avg
FROM Walmart_datasett WHERE Holiday_Flag = 0
GROUP BY Store_ID, Store
) n ON h.Store_ID = n.Store_ID
ORDER BY Uplift_Pct DESC;
---22 What is the average weekly sales by temperature range?
SELECT
CASE
WHEN Temperature BETWEEN 0  AND 32  THEN 'Cold (0-32F)'
WHEN Temperature BETWEEN 33 AND 60  THEN 'Cool (33-60F)'
WHEN Temperature BETWEEN 61 AND 80  THEN 'Warm (61-80F)'
WHEN Temperature BETWEEN 81 AND 120 THEN 'Hot (81-120F)'
END AS Temp_Bucket,
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
COUNT(*)          AS Week_Count
FROM Walmart_datasett
GROUP BY
CASE
WHEN Temperature BETWEEN 0  AND 32  THEN 'Cold (0-32F)'
WHEN Temperature BETWEEN 33 AND 60  THEN 'Cool (33-60F)'
WHEN Temperature BETWEEN 61 AND 80  THEN 'Warm (61-80F)'
WHEN Temperature BETWEEN 81 AND 120 THEN 'Hot (81-120F)'
END
ORDER BY Avg_Weekly_Sales DESC;
---23 What is the average weekly sales by fuel price range?
SELECT
CASE
WHEN Fuel_Price BETWEEN 2.00 AND 3.00 THEN 'Low (2-3)'
WHEN Fuel_Price BETWEEN 3.01 AND 3.50 THEN 'Medium (3-3.5)'
WHEN Fuel_Price BETWEEN 3.51 AND 4.00 THEN 'High (3.5-4)'
WHEN Fuel_Price > 4.00               THEN 'Very High (4+)'
END AS Fuel_Bucket,
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
COUNT(*)          AS Week_Count
FROM Walmart_datasett
GROUP BY
CASE
WHEN Fuel_Price BETWEEN 2.00 AND 3.00 THEN 'Low (2-3)'
WHEN Fuel_Price BETWEEN 3.01 AND 3.50 THEN 'Medium (3-3.5)'
WHEN Fuel_Price BETWEEN 3.51 AND 4.00 THEN 'High (3.5-4)'
WHEN Fuel_Price > 4.00               THEN 'Very High (4+)'
END
ORDER BY Avg_Weekly_Sales DESC;
---24 What is the average weekly sales by CPI?
SELECT
CASE
WHEN CPI BETWEEN 120 AND 150 THEN 'Low (120-150)'
WHEN CPI BETWEEN 151 AND 175 THEN 'Medium (150-175)'
WHEN CPI BETWEEN 176 AND 200 THEN 'High (175-200)'
WHEN CPI BETWEEN 201 AND 230 THEN 'Very High (200-230)'
END AS CPI_Bucket,
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
COUNT(*)          AS Week_Count
FROM Walmart_datasett
GROUP BY
CASE
WHEN CPI BETWEEN 120 AND 150 THEN 'Low (120-150)'
WHEN CPI BETWEEN 151 AND 175 THEN 'Medium (150-175)'
WHEN CPI BETWEEN 176 AND 200 THEN 'High (175-200)'
WHEN CPI BETWEEN 201 AND 230 THEN 'Very High (200-230)'
END
ORDER BY Avg_Weekly_Sales DESC;
---25 What is the average weekly sales by unemployment range?
SELECT
CASE
WHEN Unemployment BETWEEN 3  AND 6  THEN 'Low (3-6%)'
WHEN Unemployment BETWEEN 6  AND 8  THEN 'Medium (6-8%)'
WHEN Unemployment BETWEEN 8  AND 10 THEN 'High (8-10%)'
WHEN Unemployment BETWEEN 10 AND 15 THEN 'Very High (10%+)'
END AS Unemp_Bucket,
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
COUNT(*)          AS Week_Count
FROM Walmart_datasett
GROUP BY
CASE
WHEN Unemployment BETWEEN 3  AND 6  THEN 'Low (3-6%)'
WHEN Unemployment BETWEEN 6  AND 8  THEN 'Medium (6-8%)'        WHEN Unemployment BETWEEN 8  AND 10 THEN 'High (8-10%)'
WHEN Unemployment BETWEEN 10 AND 15 THEN 'Very High (10%+)'
END
ORDER BY Avg_Weekly_Sales DESC;
--- 26 Which of the external factors have more impact on sales?
SELECT 'Temperature'  AS Factor, MAX(Avg_Sales) - MIN(Avg_Sales) AS Sales_Range FROM (
SELECT CASE WHEN Temperature BETWEEN 0 AND 32 THEN 'Cold' WHEN Temperature BETWEEN 33 AND 60 THEN 'Cool'
WHEN Temperature BETWEEN 61 AND 80 THEN 'Warm' ELSE 'Hot' END AS Bucket,
AVG(Weekly_Sales) AS Avg_Sales FROM Walmart_datasett GROUP BY
CASE WHEN Temperature BETWEEN 0 AND 32 THEN 'Cold' WHEN Temperature BETWEEN 33 AND 60 THEN 'Cool'
WHEN Temperature BETWEEN 61 AND 80 THEN 'Warm' ELSE 'Hot' END) T
UNION ALL
SELECT 'Fuel Price', MAX(Avg_Sales) - MIN(Avg_Sales) FROM (
SELECT CASE WHEN Fuel_Price BETWEEN 2 AND 3 THEN 'Low' WHEN Fuel_Price BETWEEN 3.01 AND 3.50 THEN 'Medium'
WHEN Fuel_Price BETWEEN 3.51 AND 4 THEN 'High' ELSE 'Very High' END AS Bucket,
AVG(Weekly_Sales) AS Avg_Sales FROM Walmart_datasett GROUP BY
CASE WHEN Fuel_Price BETWEEN 2 AND 3 THEN 'Low' WHEN Fuel_Price BETWEEN 3.01 AND 3.50 THEN 'Medium'
WHEN Fuel_Price BETWEEN 3.51 AND 4 THEN 'High' ELSE 'Very High' END) F
UNION ALL
SELECT 'CPI', MAX(Avg_Sales) - MIN(Avg_Sales) FROM (
SELECT CASE WHEN CPI BETWEEN 120 AND 150 THEN 'Low' WHEN CPI BETWEEN 151 AND 175 THEN 'Medium'
WHEN CPI BETWEEN 176 AND 200 THEN 'High' ELSE 'Very High' END AS Bucket,
AVG(Weekly_Sales) AS Avg_Sales FROM Walmart_datasett GROUP BY
CASE WHEN CPI BETWEEN 120 AND 150 THEN 'Low' WHEN CPI BETWEEN 151 AND 175 THEN 'Medium'
WHEN CPI BETWEEN 176 AND 200 THEN 'High' ELSE 'Very High' END) C
UNION ALL
SELECT 'Unemployment', MAX(Avg_Sales) - MIN(Avg_Sales) FROM (
SELECT CASE WHEN Unemployment BETWEEN 3 AND 6 THEN 'Low' WHEN Unemployment BETWEEN 6 AND 8 THEN 'Medium'
WHEN Unemployment BETWEEN 8 AND 10 THEN 'High' ELSE 'Very High' END AS Bucket,
AVG(Weekly_Sales) AS Avg_Sales FROM Walmart_datasett GROUP BY
CASE WHEN Unemployment BETWEEN 3 AND 6 THEN 'Low' WHEN Unemployment BETWEEN 6 AND 8 THEN 'Medium'
WHEN Unemployment BETWEEN 8 AND 10 THEN 'High' ELSE 'Very High' END) U
ORDER BY Sales_Range DESC;
---26 What are the total sales trend across all stores week by week (Top 10)?
SELECT top 10
Date,
SUM(Weekly_Sales) AS Total_Weekly_Sales
FROM Walmart_datasett
GROUP BY Date
ORDER BY Date ASC;
---27 What are the best performimg quarter per store?
SELECT
 Store_ID, Store, Quarter,
 SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store, Quarter
HAVING SUM(Weekly_Sales) = (
 SELECT MAX(Qtr_Total)
 FROM (
 SELECT Store AS S, Quarter AS Q, SUM(Weekly_Sales) AS Qtr_Total
 FROM Walmart_datasett
 GROUP BY Store, Quarter
 ) sub
 WHERE sub.S = Walmart_datasett.Store
)
ORDER BY Total_Sales DESC;
---28 What are the worst performing stores per quarter?
SELECT
Store_ID,
Store,
Quarter,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart_datasett
GROUP BY Store_ID, Store, Quarter
HAVING SUM(Weekly_Sales) = (
SELECT MIN(Qtr_Total)
FROM (
SELECT Store AS S, Quarter AS Q, SUM(Weekly_Sales) AS Qtr_Total
FROM Walmart_datasett
GROUP BY Store, Quarter
) sub
WHERE sub.S = Walmart_datasett.Store
)
ORDER BY Total_Sales ASC;
---29 What are the sales growth from Q1 to Q4 within each year (2010 to 2012)?
SELECT
Year,
SUM(CASE WHEN Quarter = 1 THEN Weekly_Sales END) AS Q1_Sales,
SUM(CASE WHEN Quarter = 4 THEN Weekly_Sales END) AS Q4_Sales,
ROUND(
(SUM(CASE WHEN Quarter = 4 THEN Weekly_Sales END) -
SUM(CASE WHEN Quarter = 1 THEN Weekly_Sales END)) /
SUM(CASE WHEN Quarter = 1 THEN Weekly_Sales END) * 100, 2
) AS Q1_to_Q4_Growth_Pct
FROM Walmart_datasett
GROUP BY Year
ORDER BY Year ASC;
--- 30 What are stores that improved year over year from 2010 t0 2011?
SELECT
    y2010.Store_ID,
    y2010.Store,
    ROUND(y2010.Sales_2010, 2) AS Sales_2010,
    ROUND(y2011.Sales_2011, 2) AS Sales_2011,
    ROUND(((y2011.Sales_2011 - y2010.Sales_2010) / y2010.Sales_2010) * 100, 2) AS Growth_Pct
FROM (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2010
    FROM Walmart_datasett WHERE Year = 2010
    GROUP BY Store_ID, Store
) y2010
JOIN (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2011
    FROM Walmart_datasett WHERE Year = 2011
    GROUP BY Store_ID, Store
) y2011 ON y2010.Store_ID = y2011.Store_ID
WHERE y2011.Sales_2011 > y2010.Sales_2010
ORDER BY Growth_Pct DESC;
---31 What are the stores that declined year over year from 2010 to 2011?
SELECT
    y2010.Store_ID,
    y2010.Store,
    ROUND(y2010.Sales_2010, 2) AS Sales_2010,
    ROUND(y2011.Sales_2011, 2) AS Sales_2011,
    ROUND(((y2011.Sales_2011 - y2010.Sales_2010) / y2010.Sales_2010) * 100, 2) AS Growth_Pct
FROM (
SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2010
FROM Walmart_datasett WHERE Year = 2010
GROUP BY Store_ID, Store
) y2010
JOIN (
SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2011
FROM Walmart_datasett WHERE Year = 2011
GROUP BY Store_ID, Store
) y2011 ON y2010.Store_ID = y2011.Store_ID
WHERE y2011.Sales_2011 < y2010.Sales_2010
ORDER BY Growth_Pct ASC;
---32 Which of the stores is the most improved between 2010 and 2011?
SELECT TOP 1
    y2010.Store_ID,
    y2010.Store,
    ROUND(y2010.Sales_2010, 2) AS Sales_2010,
    ROUND(y2011.Sales_2011, 2) AS Sales_2011,
    ROUND(((y2011.Sales_2011 - y2010.Sales_2010) / y2010.Sales_2010) * 100, 2) AS Growth_Pct
FROM (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2010
    FROM Walmart_datasett WHERE Year = 2010
    GROUP BY Store_ID, Store
) y2010
JOIN (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2011
    FROM Walmart_datasett WHERE Year = 2011
    GROUP BY Store_ID, Store
) y2011 ON y2010.Store_ID = y2011.Store_ID
ORDER BY Growth_Pct DESC;
---33 The most declining store between 2010 and 2011
SELECT TOP 1
    y2010.Store_ID,
    y2010.Store,
    ROUND(y2010.Sales_2010, 2) AS Sales_2010,
    ROUND(y2011.Sales_2011, 2) AS Sales_2011,
    ROUND(((y2011.Sales_2011 - y2010.Sales_2010) / y2010.Sales_2010) * 100, 2) AS Growth_Pct
FROM (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2010
    FROM Walmart_datasett WHERE Year = 2010
    GROUP BY Store_ID, Store
) y2010
JOIN (
    SELECT Store_ID, Store, SUM(Weekly_Sales) AS Sales_2011
    FROM Walmart_datasett WHERE Year = 2011
    GROUP BY Store_ID, Store
) y2011 ON y2010.Store_ID = y2011.Store_ID
ORDER BY Growth_Pct ASC;
---34 Stores with the most weeks performing above their own average?
WITH Store_Avgs AS (
    SELECT Store, AVG(Weekly_Sales) AS Store_Avg
    FROM Walmart_datasett
    GROUP BY Store
)
SELECT TOP 10
    w.Store_ID,
    w.Store,
    COUNT(*) AS Weeks_Above_Own_Avg
FROM Walmart_datasett w
JOIN Store_Avgs s ON w.Store = s.Store
WHERE w.Weekly_Sales > s.Store_Avg
GROUP BY w.Store_ID, w.Store
ORDER BY Weeks_Above_Own_Avg DESC;
--- 35 Which Stores appeared in the top 10 consistently across 3 years?
SELECT
    Store,
    COUNT(DISTINCT Year) AS Years_In_Top10
FROM (
    SELECT
        Year,
        Store,
        DENSE_RANK() OVER (PARTITION BY Year ORDER BY SUM(Weekly_Sales) DESC) AS Yearly_Rank
    FROM Walmart_datasett
    GROUP BY Year, Store
) Ranked
WHERE Yearly_Rank <= 10
GROUP BY Store
HAVING COUNT(DISTINCT Year) = (SELECT COUNT(DISTINCT Year) FROM Walmart_datasett)
ORDER BY Store ASC;
---36 What are the average sales during super bowl weeks per store?
SELECT
Store_ID,Store,
AVG(Weekly_Sales) AS Avg_SuperBowl_Sales
FROM Walmart_datasett
WHERE Holiday_Name = 'Super Bowl'
GROUP BY Store_ID, Store
ORDER BY Avg_SuperBowl_Sales DESC;
---37 Between Thanksgiving and Christmas, which one drives more sales per store?
SELECT
    t.Store_ID,
    t.Store,
    ROUND(t.Thanksgiving_Avg, 2) AS Thanksgiving_Avg,
    ROUND(c.Christmas_Avg, 2)    AS Christmas_Avg,
    CASE
        WHEN t.Thanksgiving_Avg > c.Christmas_Avg THEN 'Thanksgiving'
        ELSE 'Christmas'
    END AS Better_Holiday
FROM (
    SELECT Store_ID, Store, AVG(Weekly_Sales) AS Thanksgiving_Avg
    FROM Walmart_datasett WHERE Holiday_Name = 'Thanksgiving'
    GROUP BY Store_ID, Store
) t
JOIN (
    SELECT Store_ID, Store, AVG(Weekly_Sales) AS Christmas_Avg
    FROM Walmart_datasett WHERE Holiday_Name = 'Christmas'
    GROUP BY Store_ID, Store
) c ON t.Store_ID = c.Store_ID
ORDER BY Thanksgiving_Avg DESC;
---38 What is the total sales contribution percentage per store?
SELECT
    Store_ID,
    Store,
    SUM(Weekly_Sales) AS Total_Sales,
    ROUND(SUM(Weekly_Sales) * 100.0 / SUM(SUM(Weekly_Sales)) OVER (), 2) AS Contribution_Pct
FROM Walmart_datasett
GROUP BY Store_ID, Store
ORDER BY Contribution_Pct DESC;
---39 How many stores generate 80% of total revenue?
WITH Store_Contributions AS (
    SELECT
        Store_ID,
        Store,
        SUM(Weekly_Sales) AS Total_Sales,
        ROUND(SUM(Weekly_Sales) * 100.0 / SUM(SUM(Weekly_Sales)) OVER (), 2) AS Contribution_Pct
    FROM Walmart_datasett
    GROUP BY Store_ID, Store
),
Cumulative AS (
    SELECT
Store_ID, Store, Total_Sales, Contribution_Pct,
SUM(Contribution_Pct) OVER (ORDER BY Total_Sales DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_Pct
FROM Store_Contributions
)
SELECT
Store_ID, Store, Contribution_Pct, Cumulative_Pct
FROM Cumulative
WHERE Cumulative_Pct <= 80
ORDER BY Total_Sales DESC;
---38 holiday vs non holiday revenue share of total chain revenue
SELECT
    Holiday_Label,
    SUM(Weekly_Sales)  AS Total_Sales,
    ROUND(SUM(Weekly_Sales) * 100.0 / SUM(SUM(Weekly_Sales)) OVER (), 2) AS Revenue_Share_Pct
FROM Walmart_datasett
GROUP BY Holiday_Label
ORDER BY Revenue_Share_Pct DESC;
---39 What is the revenue share per quarter?
SELECT
Quarter,
SUM(Weekly_Sales) AS Total_Sales,
ROUND(SUM(Weekly_Sales) * 100.0 / SUM(SUM(Weekly_Sales)) OVER (), 2) AS Revenue_Share_Pct
FROM Walmart_datasett
GROUP BY Quarter
ORDER BY Quarter ASC;
---40 What is the revenue share per year?
SELECT
    Year,
    SUM(Weekly_Sales) AS Total_Sales,
    ROUND(SUM(Weekly_Sales) * 100.0 / SUM(SUM(Weekly_Sales)) OVER (), 2) AS Revenue_Share_Pct
FROM Walmart_datasett
GROUP BY Year
ORDER BY Year ASC;