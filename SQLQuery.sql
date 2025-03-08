-- Display customer information who had shipments exported in 2021
SELECT *
FROM dbo.Customer
WHERE Code IN
(
    SELECT d.CustomerCode
    FROM dbo.Doc AS d
    WHERE d.IsActive = 1 AND d.Type = 2
          AND d.DocDate BETWEEN '2022-01-01' AND '2022-12-31'
          --AND YEAR(d.DocDate)=2021
    GROUP BY d.CustomerCode
)

-- Display item information with import document numbers (separated by commas) and export document numbers (separated by commas)
SELECT dd.ItemCode, it.Name AS ItemName
    ,STRING_AGG(CASE WHEN d.Type = 1 THEN d.DocNo END, ',') AS ImportDocs
    ,STRING_AGG(CASE WHEN d.Type = 2 THEN d.DocNo END, ',') AS ExportDocs
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
LEFT JOIN dbo.Item AS it ON it.Code = dd.ItemCode
WHERE d.IsActive = 1
GROUP BY dd.ItemCode, it.Name
ORDER BY dd.ItemCode

-- Summary of exports for January 2022.
-- Columns: Item code, item name, total quantity, total amount
GO
SELECT dd.ItemCode, MAX(it.Name) AS ItemName,
       SUM(dd.Quantity) AS TotalQuantity,
       SUM(dd.Amount) AS TotalAmount
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON dd.DocId = d.DocId
LEFT JOIN dbo.Item AS it ON it.Code = dd.ItemCode
WHERE d.IsActive = 1 AND d.Type = 2
  AND d.DocDate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY dd.ItemCode;

-- Display top 10 items with the highest total export quantity in 2022
GO
SELECT TOP(10) WITH TIES
       dd.ItemCode, MAX(it.Name) AS ItemName, SUM(dd.Quantity) AS TotalQuantity
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON dd.DocId = d.DocId
LEFT JOIN dbo.Item AS it ON it.Code = dd.ItemCode
WHERE d.IsActive = 1 AND d.Type = 2
  AND d.DocDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY dd.ItemCode
ORDER BY TotalQuantity DESC;

-- Summary report for 2022 by customer.
-- Columns: Customer, number of documents, total import quantity, total export quantity.
GO
SELECT d.CustomerCode, MAX(cus.Name) AS CustomerName,
       COUNT(DISTINCT d.DocId) AS DocumentCount,
       SUM(CASE WHEN d.Type = 1 THEN dd.Quantity ELSE 0 END) AS TotalQuantityIn,
       SUM(CASE WHEN d.Type = 2 THEN dd.Quantity ELSE 0 END) AS TotalQuantityOut
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON dd.DocId = d.DocId
LEFT JOIN dbo.Customer AS cus ON cus.Code = d.CustomerCode
WHERE d.IsActive = 1
  AND YEAR(d.DocDate) = 2022
GROUP BY d.CustomerCode;

-- Display the top 10 items with the highest total export quantity in 2022
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

-- Inventory summary for January 2022
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

-- Summary report for 2022 by customer.
-- Columns: Customer, number of documents, total import quantity, total export quantity.
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

-- Display document records: Document date, document number, item code, item name, import quantity, export quantity
SELECT d.DocDate, d.DocNo, dd.ItemCode, it.Name AS ItemName
       ,dd.Quantity
       ,(CASE WHEN d.Type=1 THEN dd.Quantity ELSE 0 END) AS ImportQuantity
       ,(CASE WHEN d.Type=2 THEN dd.Quantity ELSE 0 END) AS ExportQuantity
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
LEFT JOIN dbo.Item AS it ON dd.ItemCode = it.Code
WHERE d.IsActive = 1 AND YEAR(d.DocDate) = 2022
ORDER BY d.DocDate
