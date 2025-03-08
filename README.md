
# Warehouse Management System   

### Project Overview
Warehouse managers need a robust inventory management system to efficiently track stock levels, manage incoming and outgoing shipments, and optimize storage capacity. The challenge is handling large volumes of inventory data while ensuring real-time accuracy and accessibility for decision-making.

### Tools
#### Tool Used: SQL Server
[Datasets Used](https://github.com/duyyxz/SQL-Project/blob/main/Database.sql)   
[SQL Code](https://github.com/duyyxz/SQL-Project/blob/main/SQLQuery.sql)

### Questions I Wanted To Answer From the Dataset:
### 1. Display the top 10 items with the highest total export quantity in 2022

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
![](https://www.example.com/images/landscape.jpg)

### 2. Inventory summary for January 2022
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
### 3. -- Summary report for 2022 by customer.
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
### 4. Display document records
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

### Conclusion
