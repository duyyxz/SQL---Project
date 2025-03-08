
# Warehouse Management System   

### Project Overview
Warehouse managers need a robust inventory management system to efficiently track stock levels, manage incoming and outgoing shipments, and optimize storage capacity. The challenge is handling large volumes of inventory data while ensuring real-time accuracy and accessibility for decision-making.

### Tools
Tool Used: SQL Server   
[Datasets Used](https://github.com/duyyxz/SQL-Project/blob/main/Database.sql)   
[SQL Code]()

### Questions I Wanted To Answer From the Dataset:
### 1. Hiển thị thông tin 10 vật tư có tổng số lượng xuất nhiều nhất trong năm 2021
```sql
GO
SELECT TOP 10 dd.ItemCode, MAX(it.Name) AS ItemName
    , SUM(dd.Quantity) AS TotalQuantityOut
FROM dbo.Doc AS d
    LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
    LEFT JOIN dbo.Item AS it ON it.Code = dd.ItemCode
WHERE d.IsActive = 1 AND d.Type = 2
    AND d.DocDate BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY dd.ItemCode
ORDER BY TotalQuantityOut DESC
```

Result:
![](https://www.example.com/images/landscape.jpg)

### 2. Tồn kho theo kho 
```sql
GO
DECLARE @_Ngay1 DATE = '2022-01-01', @_Ngay2 DATE = '2022-01-31'
;WITH W AS (
    SELECT ItemCode
        ,SUM(Quantity) AS TonDau
        ,0 AS Nhap
        ,0 AS Xuat
    FROM dbo.OpenWarehouse
    WHERE IsActive = 1
    GROUP BY ItemCode
    UNION ALL
    SELECT dd.ItemCode
        ,SUM(CASE
            WHEN d.Type = 1 AND d.DocDate<@_Ngay1 THEN Quantity
            WHEN d.Type <> 1 AND d.DocDate<@_Ngay1 THEN -Quantity
            END) AS TonDau
        ,SUM(CASE
            WHEN d.Type = 1 AND d.DocDate>=@_Ngay1 AND d.DocDate<=@_Ngay2 THEN Quantity ELSE 0 END) AS Nhap
        ,SUM(CASE
            WHEN d.Type <> 1 AND d.DocDate>=@_Ngay1 AND d.DocDate<=@_Ngay2 THEN Quantity ELSE 0 END) AS Xuat
    FROM dbo.Doc d
    LEFT JOIN dbo.DocDetail dd ON dd.DocId = d.DocId
    WHERE d.IsActive = 1 AND d.DocDate<=@_Ngay2
    GROUP BY dd.ItemCode
)
SELECT W.ItemCode
    ,CASE WHEN GROUPING(W.ItemCode)=1 THEN 'Sum' ELSE MAX(it.Name) END AS ItemName
    ,SUM(W.TonDau) AS TonDau
    ,SUM(W.Nhap) AS Nhap
    ,SUM(W.Xuat) AS Xuat
    ,SUM(W.TonDau+W.Nhap-W.Xuat) AS TonCuoi
FROM W
LEFT JOIN dbo.Item it ON W.ItemCode=it.Code
GROUP BY GROUPING SETS ((W.ItemCode),())
```
### 3. Liệt kê danh sách chứng từ xuất trong năm 2022 cho 5 đối tượng có SL nhập nhiều nhất năm 2021
```sql
-- Buoi05_Bt09: Bảng tổng hợp năm 2022 theo từng đối tượng.
-- Danh sách cột: Đối tượng, số lượng chứng từ, tổng số lượng nhập, tổng số lượng xuất.
GO
SELECT d.CustomerCode, MAX(cus.Name) AS CustomerName
  , COUNT(DISTINCT d.DocId) AS SoluongChungTu
  , SUM(CASE WHEN d.Type = 1 THEN dd.Quantity ELSE 0 END) AS TotalQuantityIn
  , SUM(CASE WHEN d.Type = 2 THEN dd.Quantity ELSE 0 END) AS TotalQuantityOut
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON dd.DocId = d.DocId
LEFT JOIN dbo.Customer AS cus ON cus.Code = d.CustomerCode
WHERE d.IsActive = 1
  AND YEAR(d.DocDate) = 2022
GROUP BY d.CustomerCode
```
### 4. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores?
```sql
-- Buoi04_Bt02: Hiển thị bảng kê chứng từ: Ngày chứng từ, số chứng từ, mã vật tư, tên vật tư, số lượng nhập, số lượng xuất
SELECT d.DocDate, d.DocNo, dd.ItemCode, it.Name AS ItemName
       ,dd.Quantity
       ,(CASE WHEN d.Type=1 THEN dd.Quantity ELSE 0 END) AS SLNhap
       ,(CASE WHEN d.Type=2 THEN dd.Quantity ELSE 0 END) AS SLXuat
FROM dbo.Doc AS d
LEFT JOIN dbo.DocDetail AS dd ON d.DocId = dd.DocId
LEFT JOIN dbo.Item AS it ON dd.ItemCode = it.Code
WHERE d.IsActive = 1 AND YEAR(d.DocDate) = 2022
ORDER BY d.DocDate
```
### 5. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores?

### Conclusion
