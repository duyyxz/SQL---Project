
# Warehouse Management System   

### Project Overview
Warehouse managers need a robust inventory management system to efficiently track stock levels, manage incoming and outgoing shipments, and optimize storage capacity. The challenge is handling large volumes of inventory data while ensuring real-time accuracy and accessibility for decision-making.

### Tools
#### Tool Used: SQL Server
[Datasets Used](https://github.com/duyyxz/SQL-Project/blob/main/Database.sql)   
[SQL Code](https://github.com/duyyxz/SQL-Project/blob/main/SQLQuery.sql)

### Questions I Wanted To Answer From the Dataset:
### 1. Display the top 10 items with the highest total export quantity in 2022

Query:
```sql
GO
SELECT TOP 10 dd.ItemCode, MAX(it.Name) AS ItemName
    , SUM(dd.Quantity) AS TotalQuantityOut
FROM dbo.Doc AS d
    LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
    LEFT JOIN dbo.Item AS it ON it.Code = dd.ItemCode
WHERE d.IsActive = 1 AND d.Type = 2
    AND d.DocDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY dd.ItemCode
ORDER BY TotalQuantityOut DESC
```

Result:    

![](https://private-user-images.githubusercontent.com/102895063/420646239-88556c83-af62-46f8-9679-453009d17f80.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDAyNzIsIm5iZiI6MTc0MTQ5OTk3MiwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ2MjM5LTg4NTU2YzgzLWFmNjItNDZmOC05Njc5LTQ1MzAwOWQxN2Y4MC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNTU5MzJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yMTU0ZDkyYTRkYmU5OTc5Y2YxZjEyMmVhOTRmODVhNzNmOGUxZTk4ZmI1Mzg2ZThhM2QwOTE4OTQ0Yjc4YWMyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.5KMB5fVaLzlabsHZOHZ8fi8DW6LWaUqeuRNIpYigE2Y)

This query retrieves the top 10 exported items in 2022 by summing up the quantity of items exported (d.Type = 2 indicates an export transaction).
The ORDER BY TotalQuantityOut DESC ensures that the highest exported items appear first.
This insight helps in identifying the most demanded products, aiding in inventory restocking and supplier negotiations.

### 2. Inventory summary for January 2022
Query:
```sql
GO
DECLARE @_Date1 DATE = '2022-01-01', @_Date2 DATE = '2022-01-31'
;WITH W AS (
    SELECT ItemCode
        ,SUM(Quantity) AS OpeningStock
        ,0 AS Import
        ,0 AS Export
    FROM dbo.OpenWarehouse
    WHERE IsActive = 1
    GROUP BY ItemCode
    UNION ALL
    SELECT dd.ItemCode
        ,SUM(CASE
            WHEN d.Type = 1 AND d.DocDate<@_Date1 THEN Quantity
            WHEN d.Type <> 1 AND d.DocDate<@_Date1 THEN -Quantity
            END) AS OpeningStock
        ,SUM(CASE
            WHEN d.Type = 1 AND d.DocDate>=@_Date1 AND d.DocDate<=@_Date2 THEN Quantity ELSE 0 END) AS Import
        ,SUM(CASE
            WHEN d.Type <> 1 AND d.DocDate>=@_Date1 AND d.DocDate<=@_Date2 THEN Quantity ELSE 0 END) AS Export
    FROM dbo.Doc d
    LEFT JOIN dbo.DocDetail dd ON dd.DocId = d.DocId
    WHERE d.IsActive = 1 AND d.DocDate<=@_Date2
    GROUP BY dd.ItemCode
)
SELECT W.ItemCode
    ,CASE WHEN GROUPING(W.ItemCode)=1 THEN 'SUM' ELSE MAX(it.Name) END AS ItemName
    ,SUM(W.OpeningStock) AS OpeningStock
    ,SUM(W.Import) AS Import
    ,SUM(W.Export) AS Export
    ,SUM(W.OpeningStock+W.Import-W.Export) AS ClosingStock
FROM W
LEFT JOIN dbo.Item it ON W.ItemCode=it.Code
GROUP BY GROUPING SETS ((W.ItemCode),())
```
Result:    

![]([https://private-user-images.githubusercontent.com/102895063/420646239-88556c83-af62-46f8-9679-453009d17f80.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDAyNzIsIm5iZiI6MTc0MTQ5OTk3MiwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ2MjM5LTg4NTU2YzgzLWFmNjItNDZmOC05Njc5LTQ1MzAwOWQxN2Y4MC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNTU5MzJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yMTU0ZDkyYTRkYmU5OTc5Y2YxZjEyMmVhOTRmODVhNzNmOGUxZTk4ZmI1Mzg2ZThhM2QwOTE4OTQ0Yjc4YWMyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.5KMB5fVaLzlabsHZOHZ8fi8DW6LWaUqeuRNIpYigE2Y](https://private-user-images.githubusercontent.com/102895063/420646939-3e6ae545-a65c-40b6-a4c5-ffba34b86dfa.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDA3MzUsIm5iZiI6MTc0MTUwMDQzNSwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ2OTM5LTNlNmFlNTQ1LWE2NWMtNDBiNi1hNGM1LWZmYmEzNGI4NmRmYS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNjA3MTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iZGZmMmI2NDQxY2EzNmM3YzM0MjVmNGI2MThmMDVmMTI4MmUzMjBmYWM4YzgwYmRiZDEyZTM3ZmFiOWE0ZDk3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.vcXZieYI33hHn31pNz0gPgID5R0gg6unvWI4umIIJPo))

This query calculates opening stock, total imports, total exports, and closing stock for January 2022.
It uses a Common Table Expression (CTE) to compute stock movements before aggregating them.
The closing stock helps managers track inventory levels and avoid shortages or overstocking.
This report is crucial for warehouse optimization and forecasting future stock needs.
### 3. -- Summary report for 2022 by customer.
Query:
```sql
GO
SELECT d.CustomerCode, MAX(cus.Name) AS CustomerName
  , COUNT(DISTINCT d.DocId) AS DocumentCount
  , SUM(CASE WHEN d.Type = 1 THEN dd.Quantity ELSE 0 END) AS TotalQuantityIn
  , SUM(CASE WHEN d.Type = 2 THEN dd.Quantity ELSE 0 END) AS TotalQuantityOut
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON dd.DocId = d.DocId
LEFT JOIN dbo.Customer AS cus ON cus.Code = d.CustomerCode
WHERE d.IsActive = 1
  AND YEAR(d.DocDate) = 2022
GROUP BY d.CustomerCode
```
Result:    

![](https://private-user-images.githubusercontent.com/102895063/420647152-6b2477cf-efee-46c4-be8c-61b8d05ff321.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDEwMTEsIm5iZiI6MTc0MTUwMDcxMSwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ3MTUyLTZiMjQ3N2NmLWVmZWUtNDZjNC1iZThjLTYxYjhkMDVmZjMyMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNjExNTFaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zN2JiMzI0MWU5MWNhODBkMGFlOWU2MjViMTA0NTc2MWE5Mjk4MzVlMzgzZGVmNWE1OWJmOWFhZTJmM2U4NWRkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.rV3QKfyZA_v2J9kbUtFqxDHApZROuSfIs_PMQvN6_Eo)

This query summarizes customer transactions in 2022, including:
Number of documents (orders, shipments).
Total quantity of items imported.
Total quantity of items exported.
It helps in identifying top customers, analyzing purchase patterns, and making customer-centric business decisions.
Understanding which customers place large orders can help in offering better discounts or personalized services.

### 4. Display document records
Query:
```sql
SELECT d.DocDate, d.DocNo, dd.ItemCode, it.Name AS ItemName
       ,dd.Quantity
       ,(CASE WHEN d.Type=1 THEN dd.Quantity ELSE 0 END) AS ImportQuantity
       ,(CASE WHEN d.Type=2 THEN dd.Quantity ELSE 0 END) AS ExportQuantity
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
LEFT JOIN dbo.Item AS it ON dd.ItemCode = it.Code
WHERE d.IsActive = 1 AND YEAR(d.DocDate) = 2022
ORDER BY d.DocDate
```
Result:    

![](https://private-user-images.githubusercontent.com/102895063/420647208-50daf76e-faa4-4d33-b950-18d7344d5b88.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDEwNjQsIm5iZiI6MTc0MTUwMDc2NCwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ3MjA4LTUwZGFmNzZlLWZhYTQtNGQzMy1iOTUwLTE4ZDczNDRkNWI4OC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNjEyNDRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iOWIzMDg0MzJhYzY5NTFkN2M4YWQ3MmZjN2UyNDZlMDY1ZjI3OTc0MTU3MmNiMzg1ODg3OGQ5MDA2MjI0MDdlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.cb7bwUEFcN_GQDc71rFA2bDOlT6kRaG99XWOvawgFA4https://private-user-images.githubusercontent.com/102895063/420647208-50daf76e-faa4-4d33-b950-18d7344d5b88.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDE1MDEwNjQsIm5iZiI6MTc0MTUwMDc2NCwicGF0aCI6Ii8xMDI4OTUwNjMvNDIwNjQ3MjA4LTUwZGFmNzZlLWZhYTQtNGQzMy1iOTUwLTE4ZDczNDRkNWI4OC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwOVQwNjEyNDRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iOWIzMDg0MzJhYzY5NTFkN2M4YWQ3MmZjN2UyNDZlMDY1ZjI3OTc0MTU3MmNiMzg1ODg3OGQ5MDA2MjI0MDdlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.cb7bwUEFcN_GQDc71rFA2bDOlT6kRaG99XWOvawgFA4)

This query retrieves a detailed log of all inventory transactions, showing:
Date of transaction.
Document number (invoice/shipment reference).
Item details (code, name, quantity).
Import & Export quantities (separately calculated).
This data helps in tracking inventory movements, identifying delays or anomalies, and improving record accuracy.
Warehouse managers can use this to audit stock levels and verify transaction histories.
### Conclusion
By leveraging SQL to analyze warehouse data, we can extract meaningful insights that help optimize inventory management, improve stock forecasting, and enhance operational efficiency. Using these queries, decision-makers can identify trends, track item movements, and make data-driven decisions to improve warehouse performance.
