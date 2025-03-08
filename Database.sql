-- QuangLM
SET NOCOUNT ON
GO
USE master
IF EXISTS(SELECT * FROM sys.sysdatabases WHERE name='SvThucTap')
	DROP DATABASE SvThucTap


GO
USE master
CREATE DATABASE SvThucTap


GO
USE SvThucTap


GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='Item')
	DROP TABLE Item
GO
CREATE TABLE [dbo].[Item](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Code] [VARCHAR](24) NOT NULL UNIQUE,
	[Name] [NVARCHAR](128) NOT NULL DEFAULT '',
	[Unit] [NVARCHAR](24) NOT NULL DEFAULT '',
	[Type] [INT] NOT NULL DEFAULT 1
	)


GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='Customer')
	DROP TABLE Customer
GO
CREATE TABLE [dbo].[Customer](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Code] [VARCHAR](24) NOT NULL UNIQUE,
	[Name] [NVARCHAR](128) NOT NULL DEFAULT '',
	[Type] [INT] NOT NULL DEFAULT 1,
	[StartDate] [DATE] NULL,
	[EndDate] [DATE] NULL
	)
	

GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='Warehouse')
	DROP TABLE Warehouse
GO
CREATE TABLE [dbo].[Warehouse](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Code] [VARCHAR](24) NOT NULL UNIQUE,
	[Name] [NVARCHAR](128) NOT NULL DEFAULT ''
	)


GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='OpenWarehouse')
	DROP TABLE OpenWarehouse
GO
CREATE TABLE [dbo].[OpenWarehouse](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[WarehouseCode] [VARCHAR](24) NOT NULL,
	[ItemCode] [VARCHAR](24) NOT NULL,
	[Quantity] [NUMERIC](18, 5) NOT NULL DEFAULT 0,
	[Amount] [NUMERIC](18, 2) NOT NULL DEFAULT 0,
	[IsActive] [INT] NOT NULL DEFAULT 1
	)


GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='Doc')
	DROP TABLE Doc
GO
CREATE TABLE [dbo].[Doc](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[DocId] [VARCHAR](16) NOT NULL UNIQUE,
	[DocDate] [DATE] NOT NULL,
	[DocNo] [NVARCHAR](24) NOT NULL DEFAULT '',
	[Type] [INT] NOT NULL,
	[CustomerCode] [VARCHAR](24) NOT NULL,
	[WarehouseCode] [VARCHAR](24) NOT NULL,
	[Description] [NVARCHAR](128) NULL,
	[IsActive] [INT] NOT NULL DEFAULT 1
	)
GO
IF EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_Doc_DocDate' AND OBJECT_NAME(object_id) = 'Doc')
	DROP INDEX [IX_Doc_DocDate] ON [dbo].[Doc]
GO
CREATE NONCLUSTERED INDEX [IX_Doc_DocDate] ON [dbo].[Doc] (DocDate)


GO
IF EXISTS(SELECT * FROM sys.tables WHERE name='DocDetail')
	DROP TABLE DocDetail
GO
CREATE TABLE [dbo].[DocDetail](
	[Id] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[DocId] [VARCHAR](16) NOT NULL,
	[RowId] [VARCHAR](16) NOT NULL UNIQUE,
	[ItemCode] [VARCHAR](24) NOT NULL,
	[Quantity] [NUMERIC](18, 5) NOT NULL DEFAULT 0,
	[UnitCost] [NUMERIC](18, 5) NOT NULL DEFAULT 0,
	[Amount] [NUMERIC](18, 2) NOT NULL DEFAULT 0
	)
GO
IF EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_DocDetail_DocId' AND OBJECT_NAME(object_id) = 'DocDetail')
	DROP INDEX [IX_DocDetail_DocId] ON [dbo].[DocDetail]
GO
CREATE NONCLUSTERED INDEX [IX_DocDetail_DocId] ON [dbo].[DocDetail] (DocId)


TRUNCATE TABLE [Customer]
GO
SET IDENTITY_INSERT dbo.[Customer] ON
GO
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 1,N'111025',N'Công ty cổ phần Đại Dương Xanh',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 2,N'111030',N'Công ty Điện toán số 1',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 3,N'111035',N'Công ty quảng cáo Đất Việt',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 4,N'111040',N'Công ty Chế tạo điện máy Trung Quốc',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 5,N'211095',N'Công ty TNHH Đầu Tư & XNK Vạn An( TP. Khô)',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 6,N'211100',N'Công ty TNHH Đầu tư và thương mại Đồng Tâm (TPK)',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 7,N'211105',N'Công ty TNHH Đầu tư và XNK Thu Hiên (TPK)',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 8,N'211110',N'Công ty TNHH Dịch vụ thương mại và du lịch Minh Châu ( Mì Đại gia Đình)',2,NULL,NULL
--INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 9,N'HOANGLONG',N'Công ty TNHH Hoàng Long',2,NULL,NULL
--INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 10,N'HOAPHAT',N'Công ty Hòa Phát',2,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 11,N'KHACHLE',N'Khách lẻ',0,NULL,NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 12,N'NV01',N'Nguyễn Văn An',1,'01 Jan 2019','31 Oct 2019'
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 13,N'NV02',N'Trần Thị Lý',1,'01 Jan 2018',NULL
INSERT INTO [Customer] ([Id],[Code],[Name],[Type],[StartDate],[EndDate] )  SELECT 14,N'NV03',N'Tạ Đức Anh',1,'20 Jul 2018',NULL
GO
SET IDENTITY_INSERT dbo.[Customer] OFF
GO


TRUNCATE TABLE [Item]
GO
SET IDENTITY_INSERT dbo.[Item] ON
GO
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 1,N'A92',N'Xăng A92',N'lit',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 2,N'A95',N'Xăng A95',N'lit',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 3,N'DIESEL',N'Dầu diesel',N'lit',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 4,N'HH01',N'Hàng hóa 01',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 5,N'HH02',N'Hàng hóa 02',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 6,N'HH03',N'Hàng hóa 03',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 7,N'NVL01',N'Nguyên vật liệu 01',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 8,N'NVL02',N'Nguyên vật liệu 02',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 9,N'NVL03',N'Nguyên vật liệu 03',N'cái',1
--INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 10,N'TP01',N'Thành phẩm 01',N'cái',1
--INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 11,N'TP02',N'Thành phẩm 02',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 12,N'TP03',N'Thành phẩm 03',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 13,N'CC01',N'Công cụ 01',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 14,N'CC02',N'Công cụ 02',N'cái',1
INSERT INTO [Item] ([Id],[Code],[Name],[Unit],[Type] )  SELECT 15,N'CC03',N'Công cụ 03',N'cái',1
GO
SET IDENTITY_INSERT dbo.[Item] OFF
GO


TRUNCATE TABLE [Warehouse]
GO
SET IDENTITY_INSERT dbo.[Warehouse] ON
GO
INSERT INTO [Warehouse] ([Id],[Code],[Name] )  SELECT 1,N'HH',N'Kho hàng hóa'
INSERT INTO [Warehouse] ([Id],[Code],[Name] )  SELECT 2,N'NVL',N'Kho nguyên vật liệu'
--INSERT INTO [Warehouse] ([Id],[Code],[Name] )  SELECT 3,N'TP',N'Kho thành phẩm'
GO
SET IDENTITY_INSERT dbo.[Warehouse] OFF
GO


TRUNCATE TABLE [OpenWarehouse]
GO
SET IDENTITY_INSERT dbo.[OpenWarehouse] ON
GO
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 1,N'HH',N'A92',100.00000,2500000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 2,N'HH',N'A92',50.00000,1250000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 3,N'HH',N'DIESEL',100.00000,2000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 4,N'HH',N'HH02',200.00000,4000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 5,N'HH',N'HH03',300.00000,9000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 6,N'NVL',N'NVL01',100.00000,1000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 7,N'NVL',N'NVL02',200.00000,4000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 8,N'NVL',N'NVL03',300.00000,9000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 9,N'NVL',N'NVL03',200.00000,6000000.00
INSERT INTO [OpenWarehouse] ([Id],[WarehouseCode],[ItemCode],[Quantity],[Amount] )  SELECT 10,N'NVL',N'Q2',200.00000,6000000.00
GO
SET IDENTITY_INSERT dbo.[OpenWarehouse] OFF
GO


TRUNCATE TABLE [Doc]
GO
SET IDENTITY_INSERT dbo.[Doc] ON
GO
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 1,N'5520D60D','03 Mar 2018',N'0001',2,N'211110',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 2,N'8BF5541A','01 Dec 2018',N'0002',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 3,N'4F6D2BBA','12 May 2018',N'0003',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 4,N'6E0F430F','04 Dec 2018',N'0004',2,N'211100',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 5,N'1E7FF598','03 Apr 2018',N'0005',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 6,N'BEB792F6','22 Nov 2018',N'0006',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 7,N'B076F984','01 Nov 2018',N'0007',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 8,N'EF5529A5','06 Apr 2018',N'0008',2,N'211110',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 9,N'EA6015C0','21 Dec 2018',N'0009',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 10,N'3C7B4E28','08 Feb 2018',N'0010',2,N'211100',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 11,N'A0ABF9CB','15 Oct 2018',N'0011',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 12,N'D300E2C4','06 Jan 2018',N'0012',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 13,N'82FF6909','27 Oct 2018',N'0013',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 14,N'18ED2F9E','16 Nov 2018',N'0014',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 15,N'ED8DC087','11 May 2018',N'0015',2,N'211100',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 16,N'5D86B36C','24 Nov 2018',N'0016',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 17,N'C84E08E4','12 Jul 2018',N'0017',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 18,N'A5868D4E','25 Nov 2018',N'0018',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 19,N'AA4D7866','30 Apr 2018',N'0019',2,N'KHACHLE',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 20,N'D4BED653','15 Aug 2018',N'0020',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 21,N'A7D994C2','09 Jun 2018',N'0021',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 22,N'C7AF9129','19 Nov 2018',N'0022',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 23,N'A74C5F50','28 May 2018',N'0023',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 24,N'B567616B','22 May 2018',N'0024',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 25,N'1C4FE8FD','24 Jul 2018',N'0025',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 26,N'02BDCBFE','28 Jul 2018',N'0026',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 27,N'41AC58C3','18 Mar 2018',N'0027',1,N'111025',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 28,N'D35487F6','27 Feb 2018',N'0028',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 29,N'9AD72AFF','01 Dec 2018',N'0029',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 30,N'3286A489','27 May 2018',N'0030',2,N'111025',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 31,N'3FDB482A','02 Oct 2018',N'0031',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 32,N'CE000AA4','03 Jul 2018',N'0032',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 33,N'7BACB0DF','04 Jul 2018',N'0033',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 34,N'94C445D7','16 Aug 2018',N'0034',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 35,N'02CDD5B4','18 Feb 2018',N'0035',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 36,N'C7DC10EE','06 Aug 2018',N'0036',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 37,N'9BB95E2F','12 May 2018',N'0037',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 38,N'36F4B756','07 Jan 2018',N'0038',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 39,N'5F02B8C2','25 Apr 2018',N'0039',1,N'111035',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 40,N'42257D29','16 Jun 2018',N'0040',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 41,N'605EED62','29 Aug 2018',N'0041',1,N'111030',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 42,N'66940F5F','10 Jul 2018',N'0042',1,N'211110',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 43,N'FC9D4EB5','13 Jun 2018',N'0043',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 44,N'85234F83','07 Jun 2018',N'0044',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 45,N'25CCD6DE','31 Mar 2018',N'0045',1,N'NV03',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 46,N'49BA5407','10 Oct 2018',N'0046',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 47,N'87129E52','07 Apr 2018',N'0047',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 48,N'5A332531','05 Jun 2018',N'0048',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 49,N'DD69C00F','07 Oct 2018',N'0049',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 50,N'042A6D48','27 Apr 2018',N'0050',2,N'KHACHLE',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 51,N'4E87A439','15 Oct 2018',N'0051',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 52,N'1238D80C','21 Feb 2018',N'0052',2,N'211105',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 53,N'88C24651','25 Dec 2018',N'0053',2,N'KHACHLE',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 54,N'17819164','10 May 2018',N'0054',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 55,N'2CA1C572','12 Nov 2018',N'0055',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 56,N'7F6BAD29','01 Mar 2018',N'0056',2,N'111030',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 57,N'6035BDA3','24 Nov 2018',N'0057',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 58,N'A0DD8DF1','23 Apr 2018',N'0058',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 59,N'E38B4C4C','22 Aug 2018',N'0059',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 60,N'C667A8FA','15 Jun 2018',N'0060',2,N'211100',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 61,N'5EE236E2','11 Apr 2018',N'0061',2,N'111040',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 62,N'5E3B98A4','17 Jun 2018',N'0062',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 63,N'433B4F38','24 Jun 2018',N'0063',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 64,N'DB0A8A5F','27 Nov 2018',N'0064',2,N'211110',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 65,N'6B52A0E0','03 Aug 2018',N'0065',2,N'111030',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 66,N'0983C1BB','01 Dec 2018',N'0066',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 67,N'461B752B','30 Nov 2018',N'0067',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 68,N'4095A2E8','27 Jan 2018',N'0068',2,N'NV03',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 69,N'5275E909','08 Oct 2018',N'0069',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 70,N'1D0EDE5E','19 Oct 2018',N'0070',1,N'HOAPHAT',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 71,N'5ACFD660','30 Aug 2018',N'0071',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 72,N'11E6B372','04 May 2018',N'0072',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 73,N'8854DA03','04 Aug 2018',N'0073',2,N'111040',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 74,N'728727A7','08 Nov 2018',N'0074',1,N'NV02',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 75,N'9B7C47B4','22 Nov 2018',N'0075',2,N'HOAPHAT',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 76,N'A5BFB8A1','11 Aug 2018',N'0076',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 77,N'9FB7D789','25 Dec 2018',N'0077',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 78,N'38FB4AD7','31 May 2018',N'0078',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 79,N'EDE6BFE8','19 Dec 2018',N'0079',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 80,N'FD265833','30 Jun 2018',N'0080',2,N'111035',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 81,N'272FD8D3','28 Dec 2018',N'0081',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 82,N'0B8323B5','26 Oct 2018',N'0082',1,N'111025',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 83,N'097B4782','28 Sep 2018',N'0083',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 84,N'57CDE272','03 Jun 2018',N'0084',1,N'NV02',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 85,N'FA77177C','03 Mar 2018',N'0085',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 86,N'4E5C7CD7','09 Dec 2018',N'0086',2,N'KHACHLE',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 87,N'9FABB71F','10 Aug 2019',N'0087',1,N'111025',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 88,N'05E983F9','17 Sep 2019',N'0088',1,N'211100',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 89,N'EE511F00','10 Dec 2019',N'0089',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 90,N'BE36B0E2','23 Aug 2019',N'0090',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 91,N'F0CBAE25','27 Oct 2019',N'0091',1,N'111030',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 92,N'BCA3D886','03 Jan 2019',N'0092',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 93,N'04AD543A','12 Oct 2019',N'0093',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 94,N'398E398D','11 May 2019',N'0094',1,N'HOAPHAT',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 95,N'96642C70','16 Aug 2019',N'0095',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 96,N'C1C05517','25 Oct 2019',N'0096',2,N'111040',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 97,N'F0BCE8DF','31 Jul 2019',N'0097',2,N'NV03',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 98,N'9E85C754','25 Feb 2019',N'0098',1,N'211100',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 99,N'009FFAFC','15 Apr 2019',N'0099',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 100,N'9D7CEA99','30 Nov 2019',N'0100',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 101,N'CAE07CA6','22 Aug 2019',N'0101',1,N'HOAPHAT',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 102,N'0C5C479E','04 Jun 2019',N'0102',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 103,N'1D51C2CE','30 Oct 2019',N'0103',2,N'111040',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 104,N'0C32F2EB','27 Sep 2019',N'0104',2,N'211105',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 105,N'10658547','11 Jan 2019',N'0105',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 106,N'50D11A3F','03 Jun 2019',N'0106',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 107,N'AEAF124D','24 Jun 2019',N'0107',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 108,N'CB66AD6C','25 Nov 2019',N'0108',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 109,N'F4FD725C','15 Jun 2019',N'0109',1,N'NV03',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 110,N'F4BE9545','08 Sep 2019',N'0110',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 111,N'DA1FC62C','01 Jan 2019',N'0111',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 112,N'7E67E430','16 Jun 2019',N'0112',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 113,N'8E4E9FBE','13 Feb 2019',N'0113',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 114,N'6E5E2096','01 Jul 2019',N'0114',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 115,N'2972702C','28 Mar 2019',N'0115',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 116,N'82C36848','12 Dec 2019',N'0116',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 117,N'7FA49D95','25 Apr 2019',N'0117',2,N'KHACHLE',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 118,N'38AFEDA4','31 Oct 2019',N'0118',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 119,N'0237871E','21 May 2019',N'0119',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 120,N'0F04BFF3','21 Sep 2019',N'0120',2,N'211100',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 121,N'9A02ACA1','21 Oct 2019',N'0121',2,N'111025',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 122,N'2B83F7C5','05 Sep 2019',N'0122',1,N'111025',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 123,N'1E0ECA16','19 Oct 2019',N'0123',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 124,N'56D55D4B','09 Oct 2019',N'0124',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 125,N'AD209980','03 May 2019',N'0125',1,N'111035',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 126,N'F9B33A48','22 Sep 2019',N'0126',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 127,N'5F1A2A73','31 Jul 2019',N'0127',2,N'211105',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 128,N'152485DD','09 Jul 2019',N'0128',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 129,N'B22286B0','02 Apr 2019',N'0129',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 130,N'F76F1C21','10 Sep 2019',N'0130',2,N'211110',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 131,N'E21D94ED','16 Oct 2019',N'0131',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 132,N'540A54A4','02 Oct 2019',N'0132',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 133,N'2F1B0ED5','21 May 2019',N'0133',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 134,N'D9687696','12 Jul 2019',N'0134',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 135,N'9A5226E4','25 Dec 2019',N'0135',2,N'111035',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 136,N'BA8FBED0','27 Oct 2019',N'0136',1,N'NV01',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 137,N'89245F82','30 Mar 2019',N'0137',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 138,N'B6A8CF76','30 Jan 2019',N'0138',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 139,N'D130C16F','05 Sep 2019',N'0139',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 140,N'70B4B5DE','20 Jul 2019',N'0140',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 141,N'10A544FD','08 Jun 2019',N'0141',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 142,N'87D8A3F1','25 Dec 2019',N'0142',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 143,N'4510F319','26 Feb 2019',N'0143',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 144,N'C190ACCB','03 Apr 2019',N'0144',2,N'211095',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 145,N'4B8BC522','10 Apr 2019',N'0145',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 146,N'E5602181','23 Jan 2019',N'0146',2,N'NV02',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 147,N'69D56745','04 Apr 2019',N'0147',1,N'HOAPHAT',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 148,N'38AA608C','28 Jun 2019',N'0148',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 149,N'3DC51B49','01 May 2019',N'0149',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 150,N'F5EF5E82','28 Apr 2019',N'0150',2,N'111040',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 151,N'2231AF66','04 Jun 2019',N'0151',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 152,N'40DC9DF8','30 Sep 2019',N'0152',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 153,N'34759C26','24 Mar 2020',N'0153',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 154,N'CDA9A057','12 Dec 2020',N'0154',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 155,N'3037A388','09 Apr 2020',N'0155',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 156,N'5A1CBE4D','07 Oct 2020',N'0156',1,N'HOAPHAT',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 157,N'3156AFE8','05 Dec 2020',N'0157',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 158,N'D21F5DD4','26 Aug 2020',N'0158',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 159,N'EE5B3A05','06 Sep 2020',N'0159',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 160,N'2AC0A53C','15 Apr 2020',N'0160',1,N'111025',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 161,N'FFE2CFFF','12 Oct 2020',N'0161',1,N'211110',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 162,N'FBA4F0E3','19 Apr 2020',N'0162',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 163,N'A03ED31E','28 Sep 2020',N'0163',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 164,N'CA5A4EFF','03 Oct 2020',N'0164',2,N'211105',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 165,N'9092E2EB','11 Dec 2020',N'0165',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 166,N'DE8F6AC5','12 Jul 2020',N'0166',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 167,N'F4BAD413','19 Dec 2020',N'0167',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 168,N'3758036D','04 Feb 2020',N'0168',1,N'KHACHLE',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 169,N'7275F192','19 Sep 2020',N'0169',1,N'211100',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 170,N'84EF8F31','20 Aug 2020',N'0170',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 171,N'1499E245','08 May 2020',N'0171',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 172,N'D1952185','05 Mar 2020',N'0172',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 173,N'C0FC0F8D','07 Apr 2020',N'0173',2,N'111035',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 174,N'5A213F01','26 Jan 2020',N'0174',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 175,N'DDD9690C','01 Aug 2020',N'0175',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 176,N'E8AD9B82','19 Jul 2020',N'0176',1,N'HOAPHAT',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 177,N'7DB68487','27 Dec 2020',N'0177',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 178,N'8A9A9644','02 Apr 2020',N'0178',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 179,N'85D56620','24 Jun 2020',N'0179',2,N'111025',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 180,N'28F3E169','27 Mar 2020',N'0180',2,N'111025',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 181,N'1263939D','24 Sep 2020',N'0181',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 182,N'BDFFDC59','21 Dec 2020',N'0182',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 183,N'B007A8B5','08 Jul 2020',N'0183',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 184,N'4DE244BD','17 Oct 2020',N'0184',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 185,N'F72864EC','13 Aug 2020',N'0185',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 186,N'EFADD91C','28 Sep 2020',N'0186',2,N'HOANGLONG',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 187,N'CA0BE653','07 Dec 2020',N'0187',1,N'KHACHLE',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 188,N'BF15A933','08 Nov 2020',N'0188',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 189,N'4CA089BD','27 Mar 2020',N'0189',1,N'KHACHLE',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 190,N'9A911770','08 Aug 2020',N'0190',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 191,N'B7B04FCF','26 Jul 2020',N'0191',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 192,N'0202EF97','13 Jul 2020',N'0192',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 193,N'AF189DCC','21 May 2020',N'0193',1,N'NV03',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 194,N'E44D4AF4','23 Jul 2020',N'0194',1,N'211105',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 195,N'0F85BAF6','27 Dec 2020',N'0195',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 196,N'C1F602B1','03 Feb 2020',N'0196',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 197,N'676E7EB3','18 Jan 2020',N'0197',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 198,N'C9A414FA','10 Apr 2020',N'0198',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 199,N'6A24EDBE','13 Feb 2020',N'0199',2,N'111040',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 200,N'1890D0D7','24 Aug 2020',N'0200',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 201,N'8DCF484B','28 Nov 2020',N'0201',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 202,N'7CC0BE4C','22 Nov 2020',N'0202',1,N'211100',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 203,N'E199DF22','22 Aug 2020',N'0203',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 204,N'4A6E16A5','17 Feb 2020',N'0204',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 205,N'9552E45A','07 Apr 2020',N'0205',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 206,N'F06AF903','21 Aug 2020',N'0206',2,N'211110',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 207,N'D762FB5A','10 Nov 2020',N'0207',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 208,N'79C70457','09 Nov 2020',N'0208',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 209,N'EA01D9B2','24 Nov 2020',N'0209',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 210,N'362B7CA9','26 Jul 2020',N'0210',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 211,N'7F7F9055','06 Aug 2020',N'0211',2,N'211110',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 212,N'0E999483','10 Mar 2020',N'0212',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 213,N'4340BF7C','23 May 2020',N'0213',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 214,N'BE497B0A','26 Jun 2020',N'0214',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 215,N'1462825A','05 Aug 2020',N'0215',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 216,N'8A376D83','08 Sep 2020',N'0216',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 217,N'55FE9EA5','30 Mar 2020',N'0217',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 218,N'7123AC69','23 Aug 2020',N'0218',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 219,N'B77BD0BF','17 Oct 2020',N'0219',2,N'111040',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 220,N'F33D3460','10 Nov 2020',N'0220',2,N'HOANGLONG',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 221,N'1E527A26','25 Feb 2020',N'0221',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 222,N'89B0898E','12 Jul 2020',N'0222',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 223,N'A90D63F7','05 Nov 2020',N'0223',1,N'211100',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 224,N'0B957E7D','03 Jun 2020',N'0224',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 225,N'20B22ACB','09 Feb 2020',N'0225',1,N'211100',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 226,N'10753E07','26 Aug 2020',N'0226',2,N'HOAPHAT',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 227,N'27DD96E7','21 Mar 2020',N'0227',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 228,N'B5689959','05 May 2020',N'0228',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 229,N'92E41D90','21 Aug 2020',N'0229',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 230,N'7A70E960','24 Dec 2020',N'0230',2,N'211110',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 231,N'C248AE9D','02 Jan 2020',N'0231',2,N'211095',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 232,N'8585F6C0','30 Aug 2021',N'0232',2,N'NV03',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 233,N'905F4439','29 Sep 2021',N'0233',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 234,N'E282DDD5','24 Apr 2021',N'0234',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 235,N'F668CA2C','28 Aug 2021',N'0235',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 236,N'F00367AD','27 Jan 2021',N'0236',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 237,N'6D735588','06 Aug 2021',N'0237',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 238,N'212085F9','30 Jan 2021',N'0238',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 239,N'38E74814','06 May 2021',N'0239',2,N'211095',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 240,N'7510AAD7','27 Mar 2021',N'0240',2,N'211095',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 241,N'DEBCE20D','13 Dec 2021',N'0241',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 242,N'CA9CD94D','25 Mar 2021',N'0242',2,N'211100',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 243,N'C866D004','17 Mar 2021',N'0243',2,N'NV03',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 244,N'D55F4CA9','28 Sep 2021',N'0244',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 245,N'69313CE2','23 Aug 2021',N'0245',1,N'KHACHLE',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 246,N'BB86F663','24 Mar 2021',N'0246',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 247,N'0B99AE86','23 May 2021',N'0247',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 248,N'25616269','27 Mar 2021',N'0248',2,N'111040',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 249,N'6A4DABF8','02 Aug 2021',N'0249',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 250,N'2BBA5DA2','22 Sep 2021',N'0250',1,N'211100',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 251,N'E5EEA677','11 Feb 2021',N'0251',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 252,N'C9527695','10 Jun 2021',N'0252',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 253,N'B755343A','21 Apr 2021',N'0253',1,N'HOAPHAT',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 254,N'68D9D589','04 Apr 2021',N'0254',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 255,N'64741A1C','23 Apr 2021',N'0255',2,N'111025',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 256,N'527CA923','19 Dec 2021',N'0256',2,N'211095',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 257,N'CDDCC841','25 Sep 2021',N'0257',2,N'HOANGLONG',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 258,N'379C4DC8','06 Nov 2021',N'0258',2,N'HOAPHAT',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 259,N'6A8183E8','14 Feb 2021',N'0259',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 260,N'09A1D33F','17 Dec 2021',N'0260',2,N'111025',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 261,N'FCAC7A18','13 Apr 2021',N'0261',1,N'211100',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 262,N'4F855035','27 Dec 2021',N'0262',2,N'111035',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 263,N'AEFF7119','08 Apr 2021',N'0263',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 264,N'CC411A3A','08 Nov 2021',N'0264',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 265,N'72D1D64C','12 Aug 2021',N'0265',1,N'111035',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 266,N'AB0C6BA8','09 May 2021',N'0266',1,N'HOAPHAT',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 267,N'DF2575F9','26 Aug 2021',N'0267',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 268,N'7256B33E','13 Jan 2021',N'0268',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 269,N'BB3EDDBB','13 May 2021',N'0269',1,N'211110',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 270,N'05959C1E','14 Sep 2021',N'0270',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 271,N'8C3234EA','12 Jan 2021',N'0271',2,N'NV02',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 272,N'64CAA859','02 Apr 2021',N'0272',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 273,N'5E042D9E','06 Feb 2021',N'0273',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 274,N'026FABE4','01 Dec 2021',N'0274',2,N'NV01',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 275,N'B799F0ED','16 Aug 2021',N'0275',1,N'HOANGLONG',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 276,N'262E7B8E','27 Apr 2021',N'0276',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 277,N'78F6DCC9','28 Apr 2021',N'0277',1,N'111025',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 278,N'F2D99F8D','14 Nov 2021',N'0278',1,N'HOAPHAT',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 279,N'1BBA6CFA','24 Apr 2021',N'0279',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 280,N'318FAD9A','19 Jan 2021',N'0280',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 281,N'0C14B4F2','09 Dec 2021',N'0281',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 282,N'EF8ED622','07 May 2021',N'0282',2,N'211095',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 283,N'1E550CD9','23 Jun 2021',N'0283',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 284,N'A4140A77','18 Oct 2021',N'0284',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 285,N'E465170D','04 Sep 2021',N'0285',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 286,N'14993665','05 Oct 2021',N'0286',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 287,N'2875B9C5','02 May 2021',N'0287',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 288,N'78DC7C18','25 May 2021',N'0288',1,N'NV03',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 289,N'82D901F8','16 May 2021',N'0289',1,N'NV03',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 290,N'B94F7966','10 Jan 2021',N'0290',2,N'211110',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 291,N'D4D8EF4D','24 Jul 2021',N'0291',2,N'211110',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 292,N'E93398E2','28 May 2021',N'0292',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 293,N'21923A01','02 Jun 2021',N'0293',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 294,N'10AF8CCF','12 Jan 2021',N'0294',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 295,N'103F82D7','04 Feb 2021',N'0295',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 296,N'D2264DB7','21 May 2021',N'0296',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 297,N'2AAD2CB0','30 Oct 2021',N'0297',2,N'KHACHLE',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 298,N'20A3A387','23 Mar 2021',N'0298',2,N'NV03',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 299,N'5549A90E','31 Aug 2021',N'0299',2,N'211105',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 300,N'94D30B96','07 Jan 2021',N'0300',2,N'HOAPHAT',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 301,N'D4067527','24 Aug 2021',N'0301',1,N'211110',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 302,N'C6D2DCAD','14 Nov 2021',N'0302',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 303,N'0496300B','27 Apr 2021',N'0303',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 304,N'474C70FF','03 Jan 2021',N'0304',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 305,N'78237FE7','28 Jul 2021',N'0305',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 306,N'5005E90C','16 Dec 2021',N'0306',2,N'111025',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 307,N'2847E9DC','27 Jul 2021',N'0307',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 308,N'DDCFB3EA','27 Mar 2021',N'0308',2,N'HOAPHAT',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 309,N'2CCC3285','25 Feb 2021',N'0309',2,N'NV02',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 310,N'DD1440DF','27 Jun 2021',N'0310',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 311,N'B0A518C5','31 Aug 2021',N'0311',2,N'111030',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 312,N'3887CB6C','13 Nov 2021',N'0312',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 313,N'24A19B17','18 Sep 2021',N'0313',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 314,N'0328FB5F','03 Feb 2021',N'0314',2,N'211100',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 315,N'BB1783C8','10 May 2021',N'0315',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 316,N'92C0503F','15 Nov 2021',N'0316',1,N'NV02',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 317,N'972357A0','11 May 2021',N'0317',1,N'211110',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 318,N'49950CB3','07 Jun 2021',N'0318',1,N'HOANGLONG',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 319,N'FC16E96B','26 Apr 2021',N'0319',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 320,N'22ABB33C','10 Apr 2021',N'0320',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 321,N'1D4ED283','24 Dec 2022',N'0321',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 322,N'8A16CD78','10 Nov 2022',N'0322',2,N'NV03',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 323,N'436FD3A6','06 Aug 2022',N'0323',2,N'111035',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 324,N'310A71B4','12 Jun 2022',N'0324',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 325,N'E1FDCC39','03 Jun 2022',N'0325',2,N'NV02',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 326,N'AF781BB6','09 Mar 2022',N'0326',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 327,N'DD037203','12 Jul 2022',N'0327',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 328,N'B5D2172B','06 Jan 2022',N'0328',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 329,N'54E5FFA7','22 Feb 2022',N'0329',2,N'211110',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 330,N'F5D27578','12 Jan 2022',N'0330',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 331,N'813C4D2E','26 Dec 2022',N'0331',2,N'NV01',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 332,N'4F3B5E86','26 Apr 2022',N'0332',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 333,N'0A881F10','21 Jul 2022',N'0333',2,N'111040',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 334,N'CABC0F2B','16 Dec 2022',N'0334',2,N'211105',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 335,N'048F58E7','17 Dec 2022',N'0335',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 336,N'17704497','29 Nov 2022',N'0336',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 337,N'AE457D5D','07 Jul 2022',N'0337',1,N'111025',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 338,N'41BF25FD','04 Dec 2022',N'0338',1,N'HOANGLONG',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 339,N'36904EAE','16 Nov 2022',N'0339',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 340,N'500A026F','11 Aug 2022',N'0340',2,N'HOAPHAT',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 341,N'2C19F331','03 Jul 2022',N'0341',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 342,N'267BC7B3','04 Jul 2022',N'0342',2,N'111040',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 343,N'BBC7F04B','02 Feb 2022',N'0343',2,N'HOANGLONG',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 344,N'174EFBC6','03 Aug 2022',N'0344',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 345,N'65F968A5','27 Jul 2022',N'0345',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 346,N'6835CAFB','29 Nov 2022',N'0346',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 347,N'FB618DA7','24 Aug 2022',N'0347',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 348,N'6AEA4A3D','12 Oct 2022',N'0348',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 349,N'FD57FE27','19 Feb 2022',N'0349',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 350,N'312F87D2','22 Oct 2022',N'0350',2,N'111025',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 351,N'FF485FF8','02 Oct 2022',N'0351',2,N'KHACHLE',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 352,N'98560EA6','26 Jun 2022',N'0352',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 353,N'625B0B26','11 Mar 2022',N'0353',2,N'111040',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 354,N'84B5BF4E','19 Sep 2022',N'0354',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 355,N'AE400C27','11 Jun 2022',N'0355',2,N'HOANGLONG',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 356,N'01DADE7A','03 Jun 2022',N'0356',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 357,N'587A14AE','11 Oct 2022',N'0357',2,N'211110',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 358,N'3DD4EB09','20 Feb 2022',N'0358',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 359,N'B742019A','22 Jul 2022',N'0359',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 360,N'B0E17DA1','06 Nov 2022',N'0360',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 361,N'E088C3F9','21 Sep 2022',N'0361',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 362,N'9AEA27B5','31 Dec 2022',N'0362',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 363,N'BE77DCE9','21 Jan 2022',N'0363',2,N'111030',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 364,N'FF8537FA','07 Jul 2022',N'0364',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 365,N'ACAD83FE','20 Dec 2022',N'0365',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 366,N'730DA1DD','10 Nov 2022',N'0366',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 367,N'94407E71','20 Oct 2022',N'0367',1,N'HOAPHAT',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 368,N'D8754151','26 Jul 2022',N'0368',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 369,N'C40A5C1E','28 Dec 2022',N'0369',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 370,N'70CBE1E7','22 May 2022',N'0370',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 371,N'F3AF5448','09 Apr 2022',N'0371',2,N'HOANGLONG',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 372,N'FE21A21B','08 Jul 2022',N'0372',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 373,N'F4180BEB','26 Feb 2022',N'0373',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 374,N'02A4393B','13 Jun 2022',N'0374',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 375,N'68E857B2','08 Aug 2022',N'0375',2,N'211105',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 376,N'44B2CE84','30 Jan 2022',N'0376',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 377,N'A4741CDB','06 May 2022',N'0377',1,N'KHACHLE',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 378,N'A320B7B3','24 Oct 2022',N'0378',1,N'NV02',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 379,N'C505BFF9','14 Jun 2022',N'0379',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 380,N'E00AF193','13 Nov 2022',N'0380',1,N'NV03',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 381,N'B287CE1D','07 Jan 2022',N'0381',2,N'KHACHLE',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 382,N'F4372DF9','03 Mar 2022',N'0382',1,N'HOAPHAT',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 383,N'E78CDBF3','14 Dec 2022',N'0383',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 384,N'90B2164C','24 Oct 2022',N'0384',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 385,N'E45FD338','23 Sep 2022',N'0385',1,N'HOAPHAT',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 386,N'C61BE242','07 Dec 2022',N'0386',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 387,N'58F97E37','07 Jan 2022',N'0387',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 388,N'9919390A','17 Nov 2022',N'0388',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 389,N'D25FBD3B','06 Jun 2022',N'0389',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 390,N'1E4BDEF6','03 May 2022',N'0390',2,N'111035',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 391,N'69C524E0','22 Aug 2022',N'0391',2,N'211105',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 392,N'C5A068BD','28 Nov 2022',N'0392',1,N'111040',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 393,N'924990E7','28 Oct 2022',N'0393',2,N'HOANGLONG',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 394,N'6B3A8E70','29 Jan 2022',N'0394',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 395,N'928A00CC','03 May 2022',N'0395',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 396,N'960CFA22','04 May 2022',N'0396',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 397,N'5BA8E165','07 Nov 2022',N'0397',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 398,N'290CBC58','02 Jul 2022',N'0398',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 399,N'1DF53F35','17 Apr 2022',N'0399',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 400,N'89C903E8','31 Jan 2022',N'0400',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 401,N'04EC4938','12 Mar 2022',N'0401',2,N'211110',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 402,N'B8B1E67D','28 Apr 2022',N'0402',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 403,N'52AA2219','28 Sep 2022',N'0403',2,N'NV03',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 404,N'55678CDB','06 Sep 2022',N'0404',1,N'211095',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 405,N'F3E8F691','02 May 2022',N'0405',2,N'HOAPHAT',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 406,N'E57611DF','20 Sep 2022',N'0406',1,N'211100',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 407,N'C673E31C','29 Aug 2022',N'0407',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 408,N'57FB715B','29 Jul 2022',N'0408',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 409,N'8FE2C366','30 Apr 2022',N'0409',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 410,N'2060889B','26 May 2022',N'0410',2,N'HOAPHAT',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 411,N'461213F6','15 May 2023',N'0411',2,N'111035',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 412,N'F844ED57','24 Dec 2023',N'0412',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 413,N'720C843F','03 Jun 2023',N'0413',1,N'111025',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 414,N'C2ED007A','16 Mar 2023',N'0414',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 415,N'84E78C18','02 Sep 2023',N'0415',2,N'111035',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 416,N'5E7A4AC3','04 Apr 2023',N'0416',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 417,N'30F26FF6','25 Mar 2023',N'0417',2,N'111040',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 418,N'A0398152','05 Oct 2023',N'0418',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 419,N'2A0D5B3A','20 Mar 2023',N'0419',2,N'211105',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 420,N'EC6358D9','26 May 2023',N'0420',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 421,N'944A4245','11 Apr 2023',N'0421',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 422,N'66DFD3CE','10 Sep 2023',N'0422',1,N'NV03',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 423,N'270FF4AF','04 Jul 2023',N'0423',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 424,N'3C6252BE','26 Sep 2023',N'0424',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 425,N'86844527','02 Aug 2023',N'0425',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 426,N'AD8C8E3E','27 Nov 2023',N'0426',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 427,N'77FDE0BC','06 Dec 2023',N'0427',1,N'211110',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 428,N'7458086F','25 Nov 2023',N'0428',1,N'211100',N'TP',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 429,N'3F6E8C7D','26 Feb 2023',N'0429',1,N'HOAPHAT',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 430,N'8165C432','14 Jul 2023',N'0430',1,N'NV01',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 431,N'F18125E5','03 Apr 2023',N'0431',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 432,N'E2A1E21F','15 Jul 2023',N'0432',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 433,N'545D04C0','04 Nov 2023',N'0433',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 434,N'CB145B3B','25 Sep 2023',N'0434',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 435,N'7DDB4ACF','17 Jan 2023',N'0435',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 436,N'C78A995A','17 Dec 2023',N'0436',2,N'HOANGLONG',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 437,N'E7CC2D53','16 Mar 2023',N'0437',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 438,N'CB994B26','20 Jul 2023',N'0438',2,N'NV01',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 439,N'A0656E2E','14 Sep 2023',N'0439',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 440,N'C1E3B1EE','24 Jun 2023',N'0440',1,N'111030',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 441,N'46587167','07 Jan 2023',N'0441',2,N'211105',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 442,N'434D1798','01 Dec 2023',N'0442',2,N'HOANGLONG',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 443,N'412F0AD3','16 Nov 2023',N'0443',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 444,N'AD80B60C','18 Feb 2023',N'0444',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 445,N'C81F7F24','13 Feb 2023',N'0445',1,N'HOANGLONG',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 446,N'75926FE5','24 Oct 2023',N'0446',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 447,N'B9B65C70','23 Oct 2023',N'0447',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 448,N'91951BA0','27 Dec 2023',N'0448',2,N'211105',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 449,N'183BDEA9','27 Mar 2023',N'0449',1,N'111040',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 450,N'21B4B980','04 Feb 2023',N'0450',1,N'NV01',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 451,N'75AB513F','08 Mar 2023',N'0451',2,N'211105',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 452,N'1F8070AA','01 Aug 2023',N'0452',2,N'111040',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 453,N'D73CEE49','11 Aug 2023',N'0453',2,N'211110',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 454,N'2C28B84B','30 Dec 2023',N'0454',1,N'211100',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 455,N'8725D3C3','05 Mar 2023',N'0455',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 456,N'A88C8707','17 Nov 2023',N'0456',1,N'111040',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 457,N'880A6B10','28 Jan 2023',N'0457',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 458,N'F54D7120','07 Mar 2023',N'0458',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 459,N'90641A82','08 Nov 2023',N'0459',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 460,N'E24CDFB0','12 Jul 2023',N'0460',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 461,N'354EB548','12 May 2023',N'0461',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 462,N'5A120B09','18 Nov 2023',N'0462',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 463,N'B1613A59','08 Feb 2023',N'0463',2,N'111025',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 464,N'1ED5DED5','17 Jul 2023',N'0464',1,N'111025',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 465,N'A1B45B9A','12 Apr 2023',N'0465',2,N'111030',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 466,N'62909350','09 Mar 2023',N'0466',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 467,N'70A58019','17 Sep 2023',N'0467',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 468,N'1C497312','17 Sep 2023',N'0468',2,N'111040',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 469,N'4EF9B025','21 Jun 2023',N'0469',2,N'211100',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 470,N'9BFBBF4E','30 Sep 2023',N'0470',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 471,N'C4116F6A','09 Feb 2023',N'0471',2,N'HOANGLONG',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 472,N'99015083','20 Jan 2023',N'0472',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 473,N'CB445661','24 Jun 2023',N'0473',2,N'211095',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 474,N'E1A33163','08 Oct 2023',N'0474',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 475,N'32B0CD14','06 Jul 2023',N'0475',2,N'NV03',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 476,N'D4233A2A','20 Nov 2023',N'0476',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 477,N'3351CD8C','26 Apr 2023',N'0477',2,N'NV02',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 478,N'7C9ACB95','07 May 2023',N'0478',2,N'HOAPHAT',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 479,N'A1DC838D','15 Jan 2023',N'0479',2,N'211095',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 480,N'B3C297C2','17 Oct 2023',N'0480',1,N'211100',N'NVL',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 481,N'314BC7C9','23 Jan 2023',N'0481',1,N'211095',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 482,N'7B8D128C','14 May 2023',N'0482',2,N'211110',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 483,N'121BD240','13 Nov 2023',N'0483',2,N'HOANGLONG',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 484,N'71A496EB','12 Oct 2023',N'0484',2,N'NV01',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 485,N'B7E92339','01 Feb 2023',N'0485',2,N'111040',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 486,N'50CB0AA1','14 Dec 2023',N'0486',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 487,N'0CCBED96','02 Feb 2023',N'0487',1,N'111035',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 488,N'AE2CE7DA','06 Dec 2023',N'0488',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 489,N'7ADBC2AE','24 Oct 2023',N'0489',1,N'211110',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 490,N'DE7DBAA2','30 Aug 2023',N'0490',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 491,N'2E80934D','08 May 2023',N'0491',2,N'111030',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 492,N'0FA6BF57','10 Nov 2023',N'0492',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 493,N'397EEA54','01 Feb 2023',N'0493',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 494,N'4EF82999','29 Dec 2023',N'0494',2,N'HOAPHAT',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 495,N'00891C81','14 Jun 2023',N'0495',2,N'111025',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 496,N'D8D711CD','14 Oct 2023',N'0496',2,N'HOANGLONG',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 497,N'42274C08','17 Feb 2023',N'0497',2,N'HOAPHAT',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 498,N'51DCF99F','12 Sep 2024',N'0498',2,N'NV01',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 499,N'711467BD','12 Dec 2024',N'0499',1,N'NV02',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 500,N'3A14A003','23 Jul 2024',N'0500',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 501,N'C881765D','03 Nov 2024',N'0501',2,N'211100',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 502,N'ED24AC8A','19 Dec 2024',N'0502',1,N'211105',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 503,N'BDEE1C9D','07 Feb 2024',N'0503',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 504,N'C6D825BA','19 Jul 2024',N'0504',2,N'111040',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 505,N'2C69BFE7','13 Sep 2024',N'0505',1,N'NV02',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 506,N'931AE1F7','29 Feb 2024',N'0506',1,N'211105',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 507,N'4D3B16CF','21 Sep 2024',N'0507',2,N'211110',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 508,N'03B3502E','30 Apr 2024',N'0508',2,N'HOAPHAT',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 509,N'43E75264','20 Aug 2024',N'0509',1,N'211110',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 510,N'58062D8C','24 Jan 2024',N'0510',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 511,N'5A384195','30 Jul 2024',N'0511',2,N'111025',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 512,N'A43C7BB4','24 May 2024',N'0512',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 513,N'0569F182','16 Jun 2024',N'0513',1,N'211110',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 514,N'97633B20','24 Dec 2024',N'0514',2,N'KHACHLE',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 515,N'CDCE4D18','09 Jun 2024',N'0515',2,N'NV01',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 516,N'09DB91AF','20 Feb 2024',N'0516',2,N'211100',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 517,N'9D3D436C','15 Apr 2024',N'0517',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 518,N'A7950434','12 Jan 2024',N'0518',1,N'111035',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 519,N'9C41B9AF','06 Feb 2024',N'0519',2,N'111040',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 520,N'21F25DC7','22 Mar 2024',N'0520',2,N'NV01',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 521,N'821AFF1C','05 Feb 2024',N'0521',1,N'111040',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 522,N'84B183A3','30 Nov 2024',N'0522',1,N'111030',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 523,N'A99E6799','05 Jun 2024',N'0523',2,N'NV03',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 524,N'46651EA1','02 Feb 2024',N'0524',1,N'111025',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 525,N'20C44D96','08 Jan 2024',N'0525',1,N'211105',N'HH',N'Nhập hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 526,N'642FFEF2','11 Aug 2024',N'0526',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 527,N'1DBD46AA','06 Jan 2024',N'0527',2,N'211100',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 528,N'B47734D8','09 Apr 2024',N'0528',2,N'211105',N'NVL',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 529,N'57BE2643','14 Jan 2024',N'0529',2,N'111025',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 530,N'F1DDF4AE','18 May 2024',N'0530',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 531,N'41CFA24B','28 Sep 2024',N'0531',1,N'NV01',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 532,N'56FFE0AC','28 Aug 2024',N'0532',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 533,N'FA5B67A3','13 May 2024',N'0533',1,N'KHACHLE',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 534,N'71134948','13 Jul 2024',N'0534',2,N'211105',N'TP',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 535,N'CFC11F8D','13 Jul 2024',N'0535',1,N'111030',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 536,N'2480E899','26 Sep 2024',N'0536',1,N'KHACHLE',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 537,N'DE734DEA','10 Sep 2024',N'0537',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 538,N'87AAC53F','19 Sep 2024',N'0538',1,N'HOAPHAT',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 539,N'51AA7ABD','08 Mar 2024',N'0539',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 540,N'7A319A32','08 Jun 2024',N'0540',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 541,N'BC3B9153','13 May 2024',N'0541',2,N'NV03',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 542,N'90778F8F','01 May 2024',N'0542',1,N'211100',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 543,N'ED876C2D','30 Dec 2024',N'0543',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 544,N'9DEE3C27','05 Jan 2024',N'0544',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 545,N'9C258883','03 Feb 2024',N'0545',1,N'NV01',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 546,N'6DC75FF5','05 Dec 2024',N'0546',2,N'NV03',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 547,N'4E3445C7','26 Apr 2024',N'0547',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 548,N'DCDA216B','21 Mar 2024',N'0548',2,N'NV01',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 549,N'4354E48D','24 Oct 2024',N'0549',1,N'211105',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 550,N'17812C07','03 Dec 2024',N'0550',1,N'NV03',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 551,N'4ED1369F','22 Sep 2024',N'0551',2,N'KHACHLE',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 552,N'07C32023','16 Apr 2024',N'0552',2,N'211105',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 553,N'A366A708','28 Sep 2024',N'0553',2,N'111035',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 554,N'7E597302','30 Oct 2024',N'0554',2,N'111025',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 555,N'281DD2AB','01 May 2024',N'0555',2,N'211095',N'HH',N'Xuất hàng',0
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 556,N'4DD21608','28 Oct 2024',N'0556',2,N'211105',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 557,N'2F71D447','28 Sep 2024',N'0557',1,N'211095',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 558,N'2175F5C6','03 Nov 2024',N'0558',2,N'111035',N'NVL',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 559,N'8D3406F0','29 Mar 2024',N'0559',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 560,N'814D24A1','04 Dec 2024',N'0560',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 561,N'EEFC1DDF','16 Dec 2024',N'0561',1,N'NV03',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 562,N'84DF742B','04 Jul 2024',N'0562',2,N'NV03',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 563,N'5499F724','10 Dec 2024',N'0563',1,N'111035',N'TP',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 564,N'51F1E19E','30 Dec 2024',N'0564',1,N'NV02',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 565,N'D16ACA0F','24 Mar 2024',N'0565',2,N'111030',N'TP',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 566,N'ECD3E33B','18 Nov 2024',N'0566',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 567,N'07EEF718','28 Sep 2024',N'0567',2,N'211110',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 568,N'B44BDB63','01 Jun 2024',N'0568',1,N'HOANGLONG',N'NVL',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 569,N'87CA4C53','20 Jun 2024',N'0569',1,N'211105',N'HH',N'Nhập hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 570,N'EEDF79E1','06 Jul 2024',N'0570',2,N'111030',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 571,N'D5C628A7','18 Jul 2024',N'0571',2,N'NV02',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 572,N'707B3B64','25 Apr 2024',N'0572',2,N'HOANGLONG',N'HH',N'Xuất hàng',1
INSERT INTO [Doc] ([Id],[DocId],[DocDate],[DocNo],[Type],[CustomerCode],[WarehouseCode],[Description],[IsActive] )  SELECT 573,N'84D4EED5','25 Jul 2024',N'0573',1,N'KHACHLE',N'NVL',N'Nhập hàng',1
GO
SET IDENTITY_INSERT dbo.[Doc] OFF
GO


TRUNCATE TABLE [DocDetail]
GO
SET IDENTITY_INSERT dbo.[DocDetail] ON
GO
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1,N'5520D60D',N'C46FCFFE',N'NVL01',60.00000,709512.00000,42570720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2,N'5520D60D',N'5A251E7D',N'NVL03',8.00000,614795.00000,4918360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 3,N'5520D60D',N'ACAFACC7',N'NVL03',64.00000,130696.00000,8364544.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 4,N'5520D60D',N'AF78B3F5',N'NVL01',27.00000,783526.00000,21155202.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 5,N'5520D60D',N'97E360BE',N'A92',77.00000,1054947.00000,81230919.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 6,N'5520D60D',N'D8411E7A',N'HH01',54.00000,411513.00000,22221702.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 7,N'8BF5541A',N'0F7231EB',N'TP01',58.00000,931749.00000,54041442.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 8,N'8BF5541A',N'7684EE8A',N'TP01',32.00000,328069.00000,10498208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 9,N'4F6D2BBA',N'AF742A19',N'TP03',46.00000,1032553.00000,47497438.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 10,N'6E0F430F',N'76B96E00',N'DIESEL',45.00000,125846.00000,5663070.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 11,N'6E0F430F',N'C66D3272',N'A92',44.00000,370041.00000,16281804.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 12,N'6E0F430F',N'02173342',N'NVL03',76.00000,363352.00000,27614752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 13,N'6E0F430F',N'D0C7284D',N'HH01',66.00000,938490.00000,61940340.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 14,N'6E0F430F',N'8F2E50BE',N'NVL01',85.00000,136461.00000,11599185.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 15,N'1E7FF598',N'A5E397B5',N'NVL02',52.00000,916599.00000,47663148.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 16,N'1E7FF598',N'47D94CB7',N'HH03',71.00000,600864.00000,42661344.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 17,N'1E7FF598',N'3A84BD69',N'A95',22.00000,735925.00000,16190350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 18,N'1E7FF598',N'18E8F38B',N'HH01',68.00000,1021889.00000,69488452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 19,N'1E7FF598',N'CDE8B265',N'A95',18.00000,390894.00000,7036092.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 20,N'BEB792F6',N'438335CB',N'A92',25.00000,1071447.00000,26786175.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 21,N'BEB792F6',N'4DC28BD6',N'NVL03',43.00000,709182.00000,30494826.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 22,N'B076F984',N'2FF19B49',N'NVL02',66.00000,614561.00000,40561026.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 23,N'B076F984',N'AFDDE0F6',N'TP02',89.00000,272495.00000,24252055.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 24,N'EF5529A5',N'6B4AC43B',N'HH02',39.00000,442418.00000,17254302.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 25,N'EF5529A5',N'9E97E07D',N'TP01',3.00000,373459.00000,1120377.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 26,N'EF5529A5',N'E236CCF0',N'TP03',66.00000,1076706.00000,71062596.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 27,N'EF5529A5',N'9C7C1DFB',N'HH02',59.00000,572785.00000,33794315.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 28,N'EA6015C0',N'BADFFFC8',N'TP03',81.00000,780201.00000,63196281.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 29,N'3C7B4E28',N'A364FF62',N'HH03',29.00000,937407.00000,27184803.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 30,N'3C7B4E28',N'A01F5FC6',N'A95',91.00000,866639.00000,78864149.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 31,N'3C7B4E28',N'020028EE',N'NVL01',82.00000,1052356.00000,86293192.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 32,N'3C7B4E28',N'3050D995',N'TP03',18.00000,335822.00000,6044796.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 33,N'3C7B4E28',N'AB5AFBA7',N'TP02',8.00000,739333.00000,5914664.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 34,N'3C7B4E28',N'4CD732D4',N'NVL02',21.00000,297604.00000,6249684.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 35,N'A0ABF9CB',N'548E9326',N'HH02',27.00000,249758.00000,6743466.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 36,N'A0ABF9CB',N'7EBAD979',N'HH01',61.00000,1087933.00000,66363913.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 37,N'A0ABF9CB',N'D81AD2AA',N'NVL03',76.00000,1080605.00000,82125980.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 38,N'A0ABF9CB',N'1E9F75A1',N'TP01',21.00000,162029.00000,3402609.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 39,N'D300E2C4',N'6F0795F3',N'HH03',100.00000,977005.00000,97700500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 40,N'D300E2C4',N'19677686',N'HH03',75.00000,416430.00000,31232250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 41,N'82FF6909',N'F41ACE3B',N'A92',97.00000,571716.00000,55456452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 42,N'82FF6909',N'AE3A2737',N'TP02',99.00000,748623.00000,74113677.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 43,N'82FF6909',N'44E84C7D',N'NVL01',3.00000,201553.00000,604659.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 44,N'18ED2F9E',N'2823708A',N'TP02',9.00000,1083227.00000,9749043.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 45,N'18ED2F9E',N'D89322D6',N'NVL02',28.00000,467059.00000,13077652.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 46,N'18ED2F9E',N'857026C6',N'A95',66.00000,103918.00000,6858588.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 47,N'ED8DC087',N'C4BAB8CC',N'DIESEL',50.00000,536247.00000,26812350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 48,N'ED8DC087',N'9455460B',N'NVL01',29.00000,441321.00000,12798309.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 49,N'ED8DC087',N'BDC9D9A4',N'DIESEL',43.00000,267498.00000,11502414.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 50,N'ED8DC087',N'D9AF13A7',N'TP02',70.00000,317337.00000,22213590.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 51,N'ED8DC087',N'6ADB23B3',N'DIESEL',33.00000,549310.00000,18127230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 52,N'ED8DC087',N'240B1555',N'NVL03',35.00000,633763.00000,22181705.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 53,N'5D86B36C',N'A268BF45',N'TP01',25.00000,585850.00000,14646250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 54,N'5D86B36C',N'31EC7A10',N'NVL01',35.00000,397615.00000,13916525.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 55,N'5D86B36C',N'45DD535B',N'HH02',73.00000,527915.00000,38537795.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 56,N'5D86B36C',N'8BEB6147',N'NVL02',30.00000,817974.00000,24539220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 57,N'5D86B36C',N'3C89BFFA',N'TP03',11.00000,627935.00000,6907285.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 58,N'C84E08E4',N'433D9041',N'NVL02',97.00000,806533.00000,78233701.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 59,N'C84E08E4',N'F0C43B78',N'NVL01',94.00000,427817.00000,40214798.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 60,N'A5868D4E',N'10902FB3',N'NVL01',23.00000,196175.00000,4512025.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 61,N'AA4D7866',N'CF1275C6',N'HH03',43.00000,359521.00000,15459403.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 62,N'AA4D7866',N'67B9DE51',N'HH03',34.00000,585814.00000,19917676.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 63,N'D4BED653',N'54367C6F',N'NVL02',88.00000,485249.00000,42701912.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 64,N'D4BED653',N'56EAF5E1',N'TP02',11.00000,973820.00000,10712020.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 65,N'D4BED653',N'3E27D835',N'DIESEL',76.00000,900571.00000,68443396.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 66,N'D4BED653',N'891F6CFA',N'NVL01',80.00000,352232.00000,28178560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 67,N'A7D994C2',N'EAE6DFB4',N'TP01',24.00000,401148.00000,9627552.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 68,N'A7D994C2',N'E826CE97',N'TP03',43.00000,583450.00000,25088350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 69,N'A7D994C2',N'D9112143',N'HH01',66.00000,1044099.00000,68910534.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 70,N'A7D994C2',N'59DF6184',N'HH03',55.00000,790171.00000,43459405.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 71,N'A7D994C2',N'FCB7C9FB',N'HH02',25.00000,667316.00000,16682900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 72,N'C7AF9129',N'B0C9A72C',N'DIESEL',68.00000,310929.00000,21143172.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 73,N'C7AF9129',N'91B2E1D4',N'A92',65.00000,743728.00000,48342320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 74,N'C7AF9129',N'4B3CBCEB',N'A95',8.00000,639629.00000,5117032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 75,N'C7AF9129',N'1F1B4A9E',N'DIESEL',64.00000,996094.00000,63750016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 76,N'C7AF9129',N'A9508B64',N'TP03',86.00000,493629.00000,42452094.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 77,N'A74C5F50',N'43E0A83C',N'A95',91.00000,874645.00000,79592695.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 78,N'A74C5F50',N'054DC6CE',N'A92',95.00000,675138.00000,64138110.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 79,N'A74C5F50',N'A86AC773',N'A95',46.00000,520641.00000,23949486.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 80,N'B567616B',N'2B67A2DF',N'A92',58.00000,1017753.00000,59029674.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 81,N'B567616B',N'BC000485',N'HH02',87.00000,653231.00000,56831097.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 82,N'B567616B',N'7A54CD60',N'NVL01',26.00000,1088828.00000,28309528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 83,N'1C4FE8FD',N'4DD2AC2B',N'TP01',100.00000,838554.00000,83855400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 84,N'1C4FE8FD',N'D4CA8D8E',N'A92',43.00000,846913.00000,36417259.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 85,N'1C4FE8FD',N'FEEAEEF1',N'NVL02',42.00000,197688.00000,8302896.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 86,N'1C4FE8FD',N'E4216C8B',N'HH01',13.00000,795008.00000,10335104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 87,N'1C4FE8FD',N'D4A357F8',N'TP02',81.00000,910709.00000,73767429.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 88,N'02BDCBFE',N'EA95986F',N'TP01',10.00000,225593.00000,2255930.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 89,N'02BDCBFE',N'D565BB31',N'TP02',8.00000,151562.00000,1212496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 90,N'02BDCBFE',N'2D347F50',N'HH01',47.00000,210832.00000,9909104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 91,N'02BDCBFE',N'3C451BAD',N'HH03',64.00000,697048.00000,44611072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 92,N'41AC58C3',N'89716718',N'A95',33.00000,629564.00000,20775612.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 93,N'41AC58C3',N'56F549A5',N'A95',16.00000,369852.00000,5917632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 94,N'41AC58C3',N'C7901859',N'TP02',50.00000,750247.00000,37512350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 95,N'D35487F6',N'85938590',N'TP03',13.00000,349392.00000,4542096.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 96,N'D35487F6',N'49ABB58C',N'HH03',24.00000,755334.00000,18128016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 97,N'9AD72AFF',N'A754B47B',N'TP03',6.00000,155548.00000,933288.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 98,N'3286A489',N'6D5834B5',N'NVL03',70.00000,491638.00000,34414660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 99,N'3286A489',N'1FCB9137',N'TP03',91.00000,773385.00000,70378035.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 100,N'3FDB482A',N'4C936170',N'HH02',79.00000,674609.00000,53294111.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 101,N'3FDB482A',N'06EF4EEB',N'HH03',47.00000,942190.00000,44282930.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 102,N'3FDB482A',N'24444771',N'NVL01',28.00000,791600.00000,22164800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 103,N'CE000AA4',N'3EE67D00',N'HH03',14.00000,780616.00000,10928624.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 104,N'CE000AA4',N'FD1DF27F',N'TP01',21.00000,429163.00000,9012423.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 105,N'CE000AA4',N'8AF66F8B',N'HH02',74.00000,1001874.00000,74138676.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 106,N'CE000AA4',N'478A2C21',N'HH01',91.00000,994836.00000,90530076.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 107,N'7BACB0DF',N'4A4BCEB9',N'NVL01',41.00000,926385.00000,37981785.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 108,N'7BACB0DF',N'920CE754',N'TP02',6.00000,1043008.00000,6258048.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 109,N'7BACB0DF',N'573A76C9',N'DIESEL',46.00000,177935.00000,8185010.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 110,N'94C445D7',N'D2AB8E22',N'A95',80.00000,818764.00000,65501120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 111,N'94C445D7',N'2FB90BF5',N'DIESEL',19.00000,138639.00000,2634141.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 112,N'94C445D7',N'E5056A02',N'HH03',13.00000,139020.00000,1807260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 113,N'94C445D7',N'B6EBD15A',N'HH03',64.00000,1028642.00000,65833088.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 114,N'02CDD5B4',N'8789512D',N'HH01',98.00000,1089354.00000,106756692.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 115,N'02CDD5B4',N'9BE7E347',N'NVL03',21.00000,428419.00000,8996799.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 116,N'02CDD5B4',N'8C8AFB27',N'A95',78.00000,713427.00000,55647306.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 117,N'02CDD5B4',N'30A50284',N'HH03',74.00000,522635.00000,38674990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 118,N'C7DC10EE',N'DFD7A428',N'TP03',42.00000,247144.00000,10380048.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 119,N'C7DC10EE',N'82347564',N'TP02',67.00000,578871.00000,38784357.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 120,N'9BB95E2F',N'FF580A1E',N'NVL01',31.00000,279949.00000,8678419.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 121,N'9BB95E2F',N'17C72A39',N'TP03',14.00000,888517.00000,12439238.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 122,N'9BB95E2F',N'A0106E15',N'HH02',79.00000,730038.00000,57673002.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 123,N'9BB95E2F',N'A15D61AE',N'HH03',67.00000,501236.00000,33582812.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 124,N'9BB95E2F',N'CCE09B23',N'NVL03',26.00000,1017020.00000,26442520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 125,N'36F4B756',N'6B701849',N'TP03',17.00000,883062.00000,15012054.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 126,N'36F4B756',N'9A017595',N'NVL03',72.00000,152943.00000,11011896.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 127,N'36F4B756',N'9EB480D3',N'TP02',12.00000,517999.00000,6215988.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 128,N'5F02B8C2',N'68B8940C',N'A92',29.00000,384082.00000,11138378.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 129,N'42257D29',N'25B09D59',N'HH01',64.00000,807057.00000,51651648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 130,N'42257D29',N'39597A5D',N'NVL01',72.00000,268106.00000,19303632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 131,N'605EED62',N'84035E24',N'NVL01',97.00000,765667.00000,74269699.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 132,N'605EED62',N'81D7DFE0',N'NVL01',23.00000,579620.00000,13331260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 133,N'605EED62',N'F2FD2954',N'TP03',45.00000,655945.00000,29517525.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 134,N'605EED62',N'0E0262B3',N'DIESEL',42.00000,799308.00000,33570936.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 135,N'605EED62',N'73892B3A',N'NVL03',36.00000,362319.00000,13043484.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 136,N'605EED62',N'3D839101',N'HH02',57.00000,926764.00000,52825548.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 137,N'66940F5F',N'896B8F5F',N'NVL03',97.00000,368386.00000,35733442.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 138,N'FC9D4EB5',N'1391224E',N'DIESEL',68.00000,932980.00000,63442640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 139,N'FC9D4EB5',N'ECDCD445',N'A92',92.00000,866008.00000,79672736.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 140,N'FC9D4EB5',N'057B6288',N'A95',8.00000,160378.00000,1283024.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 141,N'FC9D4EB5',N'1AFE3C08',N'NVL03',89.00000,950693.00000,84611677.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 142,N'FC9D4EB5',N'9B9867A0',N'A95',101.00000,671943.00000,67866243.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 143,N'FC9D4EB5',N'67268432',N'NVL02',9.00000,692800.00000,6235200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 144,N'85234F83',N'60F62D73',N'TP01',66.00000,319620.00000,21094920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 145,N'85234F83',N'2A353833',N'TP01',97.00000,436500.00000,42340500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 146,N'85234F83',N'35F19548',N'NVL02',39.00000,604616.00000,23580024.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 147,N'85234F83',N'3BE2F89B',N'TP02',8.00000,358399.00000,2867192.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 148,N'85234F83',N'8D8038ED',N'NVL02',83.00000,215827.00000,17913641.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 149,N'25CCD6DE',N'AA6A0E96',N'A92',98.00000,816593.00000,80026114.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 150,N'25CCD6DE',N'E53556CF',N'NVL01',90.00000,963071.00000,86676390.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 151,N'49BA5407',N'99F42732',N'A95',69.00000,846670.00000,58420230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 152,N'49BA5407',N'8AB84FB4',N'NVL03',46.00000,134641.00000,6193486.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 153,N'49BA5407',N'57474DF9',N'TP03',25.00000,370395.00000,9259875.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 154,N'87129E52',N'8D1FC1B6',N'TP02',2.00000,134408.00000,268816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 155,N'87129E52',N'FFB615BD',N'TP03',83.00000,1076097.00000,89316051.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 156,N'87129E52',N'41C79C0A',N'NVL01',54.00000,515971.00000,27862434.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 157,N'5A332531',N'CE93B3AA',N'HH03',17.00000,730665.00000,12421305.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 158,N'5A332531',N'E14B688E',N'NVL03',28.00000,871297.00000,24396316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 159,N'DD69C00F',N'6569151C',N'HH01',75.00000,691505.00000,51862875.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 160,N'DD69C00F',N'085F06D2',N'HH01',92.00000,784510.00000,72174920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 161,N'DD69C00F',N'0049CE60',N'HH02',43.00000,356023.00000,15308989.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 162,N'DD69C00F',N'BC9525CF',N'HH03',45.00000,618671.00000,27840195.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 163,N'DD69C00F',N'90372E3F',N'HH03',2.00000,338745.00000,677490.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 164,N'042A6D48',N'35C3ECFF',N'HH02',98.00000,728046.00000,71348508.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 165,N'042A6D48',N'311D6E29',N'TP02',72.00000,760558.00000,54760176.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 166,N'042A6D48',N'ECA5053F',N'HH03',53.00000,160297.00000,8495741.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 167,N'4E87A439',N'011B548C',N'NVL03',9.00000,338255.00000,3044295.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 168,N'4E87A439',N'20B2595D',N'NVL02',16.00000,911071.00000,14577136.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 169,N'4E87A439',N'7FE5352B',N'NVL01',64.00000,533867.00000,34167488.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 170,N'4E87A439',N'0575D533',N'HH01',2.00000,822431.00000,1644862.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 171,N'4E87A439',N'74215661',N'HH03',29.00000,405631.00000,11763299.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 172,N'4E87A439',N'76D696D2',N'DIESEL',28.00000,918216.00000,25710048.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 173,N'1238D80C',N'289DA4BE',N'NVL03',86.00000,317180.00000,27277480.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 174,N'1238D80C',N'2FE69845',N'TP01',41.00000,368937.00000,15126417.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 175,N'1238D80C',N'20BBF7D2',N'A95',59.00000,1077737.00000,63586483.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 176,N'1238D80C',N'E14B9683',N'TP01',19.00000,256172.00000,4867268.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 177,N'88C24651',N'0F0B388A',N'A92',16.00000,131676.00000,2106816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 178,N'88C24651',N'AF9EF373',N'NVL02',44.00000,920513.00000,40502572.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 179,N'88C24651',N'4DAF1567',N'NVL01',51.00000,1053822.00000,53744922.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 180,N'17819164',N'C89182D7',N'A92',44.00000,849659.00000,37384996.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 181,N'17819164',N'40A57E99',N'HH02',47.00000,881617.00000,41435999.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 182,N'17819164',N'D4105D58',N'NVL03',43.00000,998032.00000,42915376.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 183,N'2CA1C572',N'7A41EAA7',N'A92',62.00000,793715.00000,49210330.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 184,N'2CA1C572',N'2FCCB4B4',N'NVL01',8.00000,620268.00000,4962144.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 185,N'2CA1C572',N'26F3DEE9',N'TP02',69.00000,400508.00000,27635052.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 186,N'2CA1C572',N'1E8E599B',N'HH02',72.00000,263211.00000,18951192.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 187,N'2CA1C572',N'FBBCA7F3',N'NVL01',59.00000,380305.00000,22437995.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 188,N'2CA1C572',N'F8856436',N'HH01',39.00000,737958.00000,28780362.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 189,N'7F6BAD29',N'4B81D9D4',N'NVL01',53.00000,520909.00000,27608177.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 190,N'7F6BAD29',N'B63BCEE4',N'NVL03',73.00000,329367.00000,24043791.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 191,N'7F6BAD29',N'BCC60FDF',N'TP03',81.00000,517191.00000,41892471.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 192,N'7F6BAD29',N'C0C7C365',N'DIESEL',58.00000,597496.00000,34654768.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 193,N'7F6BAD29',N'E830B808',N'DIESEL',69.00000,997590.00000,68833710.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 194,N'7F6BAD29',N'B8407975',N'HH02',56.00000,982415.00000,55015240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 195,N'6035BDA3',N'3E3ACA88',N'TP01',69.00000,966709.00000,66702921.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 196,N'6035BDA3',N'14BD2A24',N'HH02',68.00000,931512.00000,63342816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 197,N'6035BDA3',N'9398F4A9',N'HH01',101.00000,609807.00000,61590507.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 198,N'A0DD8DF1',N'ABB6220D',N'HH03',61.00000,683218.00000,41676298.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 199,N'A0DD8DF1',N'F4768E67',N'NVL03',36.00000,372153.00000,13397508.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 200,N'A0DD8DF1',N'98F34E10',N'TP02',50.00000,1093132.00000,54656600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 201,N'E38B4C4C',N'1AC5D268',N'DIESEL',29.00000,913883.00000,26502607.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 202,N'E38B4C4C',N'0718E3F6',N'TP03',87.00000,943414.00000,82077018.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 203,N'E38B4C4C',N'8DCB503C',N'NVL02',23.00000,692489.00000,15927247.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 204,N'E38B4C4C',N'74D9A7B8',N'HH03',38.00000,256586.00000,9750268.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 205,N'E38B4C4C',N'BC299CFA',N'A92',86.00000,1063617.00000,91471062.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 206,N'C667A8FA',N'A3C2C780',N'TP01',89.00000,1066469.00000,94915741.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 207,N'5EE236E2',N'C05D5631',N'HH01',100.00000,486203.00000,48620300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 208,N'5EE236E2',N'3077B5C6',N'NVL02',6.00000,445249.00000,2671494.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 209,N'5EE236E2',N'48CD7519',N'A95',40.00000,935325.00000,37413000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 210,N'5EE236E2',N'CF107BE2',N'NVL01',33.00000,1038073.00000,34256409.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 211,N'5E3B98A4',N'2247C0F7',N'HH02',50.00000,266788.00000,13339400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 212,N'5E3B98A4',N'517C9277',N'NVL03',54.00000,351716.00000,18992664.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 213,N'5E3B98A4',N'46261643',N'HH01',39.00000,385288.00000,15026232.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 214,N'5E3B98A4',N'7E9BBE1F',N'TP01',24.00000,216264.00000,5190336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 215,N'5E3B98A4',N'43C01899',N'NVL03',42.00000,272849.00000,11459658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 216,N'5E3B98A4',N'E250DB4C',N'DIESEL',20.00000,559892.00000,11197840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 217,N'433B4F38',N'114BC559',N'TP01',80.00000,638040.00000,51043200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 218,N'433B4F38',N'2466A338',N'NVL03',18.00000,446524.00000,8037432.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 219,N'433B4F38',N'ABF2A99D',N'HH03',93.00000,363497.00000,33805221.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 220,N'433B4F38',N'F1384651',N'HH02',62.00000,949700.00000,58881400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 221,N'DB0A8A5F',N'1E203D43',N'TP01',40.00000,575792.00000,23031680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 222,N'DB0A8A5F',N'3DEA15A7',N'TP03',80.00000,119721.00000,9577680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 223,N'DB0A8A5F',N'8A288682',N'A92',36.00000,195856.00000,7050816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 224,N'DB0A8A5F',N'9D60C3B4',N'TP02',82.00000,836480.00000,68591360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 225,N'6B52A0E0',N'ADD08AD4',N'HH01',44.00000,149891.00000,6595204.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 226,N'0983C1BB',N'D9EE3847',N'TP03',51.00000,989613.00000,50470263.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 227,N'0983C1BB',N'8EA8CF71',N'NVL03',34.00000,825898.00000,28080532.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 228,N'0983C1BB',N'2B07274E',N'NVL02',94.00000,197745.00000,18588030.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 229,N'0983C1BB',N'BA23C59F',N'NVL03',82.00000,784810.00000,64354420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 230,N'0983C1BB',N'F64A9CA4',N'DIESEL',55.00000,462429.00000,25433595.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 231,N'461B752B',N'38FFF3D1',N'HH03',96.00000,917070.00000,88038720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 232,N'461B752B',N'B324764D',N'A95',39.00000,659864.00000,25734696.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 233,N'461B752B',N'1D735BD1',N'HH02',70.00000,710276.00000,49719320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 234,N'461B752B',N'A19D9CAA',N'TP02',96.00000,373425.00000,35848800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 235,N'461B752B',N'697BB408',N'NVL01',94.00000,203708.00000,19148552.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 236,N'461B752B',N'E47AB71C',N'HH03',23.00000,606757.00000,13955411.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 237,N'4095A2E8',N'ED1B5691',N'HH02',65.00000,747776.00000,48605440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 238,N'4095A2E8',N'96512601',N'A92',87.00000,877931.00000,76379997.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 239,N'5275E909',N'3A8EC7C7',N'TP01',19.00000,651178.00000,12372382.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 240,N'5275E909',N'AF5D11A9',N'A95',46.00000,552892.00000,25433032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 241,N'5275E909',N'FB4EC2E0',N'HH02',100.00000,967667.00000,96766700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 242,N'1D0EDE5E',N'C2BA36E2',N'HH01',69.00000,902537.00000,62275053.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 243,N'1D0EDE5E',N'FD9E5C79',N'NVL03',100.00000,930551.00000,93055100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 244,N'1D0EDE5E',N'51C17789',N'TP03',31.00000,724279.00000,22452649.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 245,N'5ACFD660',N'1EF70CFC',N'HH03',75.00000,241829.00000,18137175.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 246,N'11E6B372',N'73AB3C0E',N'NVL01',45.00000,147038.00000,6616710.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 247,N'11E6B372',N'1F7975AF',N'TP02',37.00000,977924.00000,36183188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 248,N'11E6B372',N'308EB1A6',N'TP03',20.00000,841619.00000,16832380.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 249,N'11E6B372',N'A37C6360',N'HH03',23.00000,303217.00000,6973991.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 250,N'11E6B372',N'B0D0200B',N'TP03',37.00000,759509.00000,28101833.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 251,N'8854DA03',N'8E8C8F87',N'A95',14.00000,752184.00000,10530576.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 252,N'8854DA03',N'A3E53E3B',N'DIESEL',74.00000,454777.00000,33653498.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 253,N'8854DA03',N'09554955',N'TP02',28.00000,855833.00000,23963324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 254,N'728727A7',N'D3910F11',N'NVL03',86.00000,284765.00000,24489790.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 255,N'728727A7',N'219F4D85',N'HH02',48.00000,487093.00000,23380464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 256,N'728727A7',N'AF428A6B',N'A92',83.00000,1090868.00000,90542044.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 257,N'728727A7',N'857022D0',N'HH02',3.00000,420858.00000,1262574.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 258,N'9B7C47B4',N'A9D4B87E',N'TP01',37.00000,427930.00000,15833410.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 259,N'9B7C47B4',N'C19878A6',N'HH02',5.00000,363446.00000,1817230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 260,N'9B7C47B4',N'075B9F85',N'TP01',90.00000,401688.00000,36151920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 261,N'9B7C47B4',N'80443D80',N'TP01',9.00000,184735.00000,1662615.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 262,N'A5BFB8A1',N'03DD1B64',N'TP03',4.00000,780985.00000,3123940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 263,N'A5BFB8A1',N'576D82E5',N'TP02',84.00000,807432.00000,67824288.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 264,N'A5BFB8A1',N'EAF09396',N'DIESEL',8.00000,692236.00000,5537888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 265,N'A5BFB8A1',N'761D00BB',N'NVL02',71.00000,691009.00000,49061639.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 266,N'9FB7D789',N'72697947',N'TP01',6.00000,965212.00000,5791272.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 267,N'9FB7D789',N'A329BCC1',N'TP03',86.00000,990306.00000,85166316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 268,N'9FB7D789',N'9CC82DF2',N'DIESEL',76.00000,480438.00000,36513288.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 269,N'38FB4AD7',N'8A318EE1',N'DIESEL',69.00000,621355.00000,42873495.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 270,N'EDE6BFE8',N'4A75C295',N'A92',15.00000,469958.00000,7049370.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 271,N'EDE6BFE8',N'D7D5E190',N'TP01',61.00000,957369.00000,58399509.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 272,N'FD265833',N'95AADE24',N'HH02',63.00000,860556.00000,54215028.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 273,N'FD265833',N'D1B53564',N'HH01',83.00000,895742.00000,74346586.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 274,N'FD265833',N'433CBB3C',N'TP03',95.00000,1044673.00000,99243935.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 275,N'FD265833',N'8D82D542',N'NVL02',56.00000,489667.00000,27421352.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 276,N'272FD8D3',N'62153ECE',N'NVL01',27.00000,287791.00000,7770357.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 277,N'272FD8D3',N'6E1D3EB5',N'HH01',42.00000,184896.00000,7765632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 278,N'272FD8D3',N'E76A14CB',N'DIESEL',60.00000,767747.00000,46064820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 279,N'0B8323B5',N'116B28B5',N'TP03',5.00000,722782.00000,3613910.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 280,N'0B8323B5',N'7587536C',N'DIESEL',13.00000,1091187.00000,14185431.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 281,N'0B8323B5',N'90B0E6ED',N'TP02',60.00000,210078.00000,12604680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 282,N'0B8323B5',N'C0DD52ED',N'HH01',14.00000,771989.00000,10807846.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 283,N'097B4782',N'85043B0C',N'A95',31.00000,909638.00000,28198778.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 284,N'097B4782',N'8DEF96C4',N'HH03',50.00000,970165.00000,48508250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 285,N'097B4782',N'53402FE2',N'NVL03',91.00000,357936.00000,32572176.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 286,N'57CDE272',N'9A7117CD',N'A95',27.00000,629188.00000,16988076.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 287,N'57CDE272',N'2039139D',N'TP02',22.00000,480147.00000,10563234.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 288,N'57CDE272',N'65740E86',N'NVL02',90.00000,375910.00000,33831900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 289,N'FA77177C',N'C7642F7F',N'DIESEL',11.00000,968011.00000,10648121.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 290,N'FA77177C',N'8C98FDE6',N'NVL02',69.00000,912938.00000,62992722.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 291,N'FA77177C',N'B5971629',N'HH01',43.00000,133808.00000,5753744.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 292,N'FA77177C',N'874D52BA',N'HH02',79.00000,510802.00000,40353358.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 293,N'4E5C7CD7',N'2610DA18',N'A95',51.00000,683868.00000,34877268.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 294,N'4E5C7CD7',N'8BA83060',N'NVL02',65.00000,785577.00000,51062505.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 295,N'4E5C7CD7',N'AE9FEADB',N'TP01',99.00000,744278.00000,73683522.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 296,N'9FABB71F',N'B553ACCD',N'A92',94.00000,925492.00000,86996248.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 297,N'9FABB71F',N'B031C5E4',N'TP01',47.00000,771168.00000,36244896.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 298,N'05E983F9',N'46E724D6',N'TP01',52.00000,476513.00000,24778676.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 299,N'05E983F9',N'F8959407',N'HH02',28.00000,1069404.00000,29943312.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 300,N'05E983F9',N'2732809D',N'NVL03',75.00000,940275.00000,70520625.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 301,N'05E983F9',N'152293C4',N'DIESEL',17.00000,507054.00000,8619918.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 302,N'EE511F00',N'1D95D0B5',N'TP03',73.00000,841930.00000,61460890.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 303,N'EE511F00',N'F07D289D',N'A92',49.00000,311055.00000,15241695.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 304,N'BE36B0E2',N'05390880',N'DIESEL',98.00000,965441.00000,94613218.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 305,N'BE36B0E2',N'63A32223',N'HH03',73.00000,883986.00000,64530978.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 306,N'F0CBAE25',N'A7C6EAD4',N'HH03',15.00000,344759.00000,5171385.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 307,N'F0CBAE25',N'C06D163F',N'HH01',79.00000,497225.00000,39280775.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 308,N'F0CBAE25',N'FDC78BF5',N'NVL01',11.00000,529831.00000,5828141.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 309,N'F0CBAE25',N'9BAE4FC7',N'DIESEL',45.00000,565434.00000,25444530.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 310,N'BCA3D886',N'40C1F81E',N'NVL01',88.00000,507172.00000,44631136.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 311,N'BCA3D886',N'F81F9896',N'DIESEL',91.00000,802492.00000,73026772.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 312,N'BCA3D886',N'36CB9A8D',N'TP01',70.00000,163104.00000,11417280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 313,N'04AD543A',N'4EF8C5AD',N'HH01',32.00000,321487.00000,10287584.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 314,N'04AD543A',N'3E7B76E9',N'DIESEL',16.00000,317448.00000,5079168.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 315,N'04AD543A',N'22A38145',N'A92',43.00000,335670.00000,14433810.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 316,N'398E398D',N'FB55E009',N'A92',76.00000,159577.00000,12127852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 317,N'398E398D',N'0EF46AC3',N'NVL02',5.00000,260656.00000,1303280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 318,N'398E398D',N'7C0F32E8',N'TP03',21.00000,479029.00000,10059609.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 319,N'96642C70',N'AECBF2A0',N'HH02',23.00000,209317.00000,4814291.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 320,N'96642C70',N'9B57B364',N'A95',81.00000,299429.00000,24253749.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 321,N'96642C70',N'F37C0C19',N'A95',22.00000,203996.00000,4487912.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 322,N'96642C70',N'950E7252',N'HH02',27.00000,421473.00000,11379771.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 323,N'96642C70',N'1A403886',N'A92',60.00000,583855.00000,35031300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 324,N'96642C70',N'929E8B97',N'NVL01',3.00000,303317.00000,909951.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 325,N'C1C05517',N'AE92D8A5',N'TP02',48.00000,971849.00000,46648752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 326,N'C1C05517',N'BAA10C87',N'DIESEL',64.00000,619598.00000,39654272.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 327,N'C1C05517',N'7E58A70A',N'HH01',82.00000,347925.00000,28529850.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 328,N'F0BCE8DF',N'1D0D6CEE',N'TP03',9.00000,128768.00000,1158912.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 329,N'F0BCE8DF',N'E564D382',N'NVL01',42.00000,574419.00000,24125598.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 330,N'F0BCE8DF',N'5A1893D9',N'DIESEL',55.00000,394086.00000,21674730.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 331,N'9E85C754',N'0FBE088B',N'DIESEL',49.00000,884115.00000,43321635.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 332,N'9E85C754',N'F1A75DA1',N'NVL01',92.00000,919168.00000,84563456.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 333,N'9E85C754',N'555AF6F1',N'NVL01',68.00000,795673.00000,54105764.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 334,N'009FFAFC',N'A850C15F',N'HH02',3.00000,201677.00000,605031.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 335,N'009FFAFC',N'09FB806C',N'TP03',61.00000,780572.00000,47614892.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 336,N'009FFAFC',N'2E0ED99C',N'NVL02',70.00000,158581.00000,11100670.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 337,N'9D7CEA99',N'EA99E6EC',N'TP02',28.00000,1094136.00000,30635808.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 338,N'9D7CEA99',N'21CECFA4',N'NVL01',26.00000,768744.00000,19987344.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 339,N'9D7CEA99',N'012DC6D4',N'HH03',17.00000,450216.00000,7653672.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 340,N'9D7CEA99',N'60EBD9D6',N'TP03',34.00000,993961.00000,33794674.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 341,N'CAE07CA6',N'61E76227',N'NVL01',15.00000,832989.00000,12494835.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 342,N'CAE07CA6',N'A4C13898',N'DIESEL',53.00000,221355.00000,11731815.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 343,N'CAE07CA6',N'B314C86E',N'NVL02',62.00000,862580.00000,53479960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 344,N'CAE07CA6',N'E7893F67',N'NVL01',37.00000,748545.00000,27696165.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 345,N'CAE07CA6',N'41BA6B3B',N'TP01',7.00000,332360.00000,2326520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 346,N'CAE07CA6',N'7C7AB6EB',N'NVL03',70.00000,180501.00000,12635070.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 347,N'0C5C479E',N'400B278B',N'HH01',43.00000,431895.00000,18571485.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 348,N'0C5C479E',N'AB3F6C3C',N'TP01',68.00000,635875.00000,43239500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 349,N'0C5C479E',N'F0B68299',N'NVL01',100.00000,290795.00000,29079500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 350,N'0C5C479E',N'0EF8D373',N'A95',72.00000,373181.00000,26869032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 351,N'0C5C479E',N'B921BC49',N'TP01',77.00000,378399.00000,29136723.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 352,N'1D51C2CE',N'8EE459DF',N'NVL02',54.00000,808029.00000,43633566.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 353,N'1D51C2CE',N'DD26EE91',N'NVL01',20.00000,861245.00000,17224900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 354,N'1D51C2CE',N'F483A8B0',N'HH01',6.00000,713081.00000,4278486.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 355,N'0C32F2EB',N'C6721670',N'A95',30.00000,634986.00000,19049580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 356,N'0C32F2EB',N'F5E67C0B',N'A95',33.00000,437829.00000,14448357.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 357,N'0C32F2EB',N'DD425001',N'TP03',20.00000,1030493.00000,20609860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 358,N'0C32F2EB',N'0F715D58',N'HH03',18.00000,258013.00000,4644234.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 359,N'10658547',N'F05C55FF',N'HH02',29.00000,354310.00000,10274990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 360,N'10658547',N'F1BFA61D',N'TP03',70.00000,642536.00000,44977520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 361,N'50D11A3F',N'CC31F46C',N'NVL03',21.00000,294418.00000,6182778.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 362,N'50D11A3F',N'E5E49A8F',N'NVL02',23.00000,987688.00000,22716824.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 363,N'50D11A3F',N'587AABCD',N'HH01',100.00000,236077.00000,23607700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 364,N'50D11A3F',N'85D09BF2',N'DIESEL',5.00000,437237.00000,2186185.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 365,N'AEAF124D',N'F1B8D735',N'DIESEL',72.00000,308793.00000,22233096.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 366,N'AEAF124D',N'52B668AF',N'NVL01',25.00000,689425.00000,17235625.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 367,N'AEAF124D',N'64E128A5',N'NVL01',39.00000,341953.00000,13336167.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 368,N'AEAF124D',N'4383FBE8',N'DIESEL',100.00000,697631.00000,69763100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 369,N'AEAF124D',N'524BA9F4',N'A92',41.00000,180024.00000,7380984.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 370,N'CB66AD6C',N'A873E672',N'A92',23.00000,360397.00000,8289131.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 371,N'CB66AD6C',N'31403C4B',N'NVL03',54.00000,592817.00000,32012118.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 372,N'CB66AD6C',N'C06BE9C1',N'TP02',20.00000,734234.00000,14684680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 373,N'F4FD725C',N'64805E79',N'NVL03',71.00000,706426.00000,50156246.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 374,N'F4FD725C',N'35AC423C',N'NVL03',95.00000,108313.00000,10289735.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 375,N'F4BE9545',N'FE33EE9D',N'HH03',1.00000,879094.00000,879094.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 376,N'DA1FC62C',N'C4E05E26',N'A95',34.00000,762207.00000,25915038.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 377,N'DA1FC62C',N'E5882C3B',N'DIESEL',56.00000,746451.00000,41801256.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 378,N'DA1FC62C',N'510D508F',N'TP02',96.00000,178640.00000,17149440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 379,N'DA1FC62C',N'E550ADD7',N'HH01',41.00000,689159.00000,28255519.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 380,N'7E67E430',N'F0A493BC',N'TP03',79.00000,878818.00000,69426622.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 381,N'7E67E430',N'4456012B',N'NVL02',76.00000,1066791.00000,81076116.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 382,N'7E67E430',N'2E7DD2CE',N'TP03',51.00000,337993.00000,17237643.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 383,N'8E4E9FBE',N'6AB1EF01',N'HH03',8.00000,1034295.00000,8274360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 384,N'8E4E9FBE',N'4850312C',N'TP03',65.00000,405188.00000,26337220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 385,N'8E4E9FBE',N'ACA27A33',N'NVL03',45.00000,112062.00000,5042790.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 386,N'6E5E2096',N'B4966DE9',N'NVL03',93.00000,723279.00000,67264947.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 387,N'6E5E2096',N'E1281D87',N'A92',95.00000,662724.00000,62958780.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 388,N'6E5E2096',N'ACD5F6F7',N'HH03',29.00000,317131.00000,9196799.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 389,N'2972702C',N'6F4F6279',N'A95',60.00000,1079955.00000,64797300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 390,N'2972702C',N'B811CD10',N'TP01',6.00000,149567.00000,897402.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 391,N'82C36848',N'F977BDDB',N'TP03',24.00000,324179.00000,7780296.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 392,N'82C36848',N'E02F16E2',N'TP03',44.00000,604995.00000,26619780.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 393,N'82C36848',N'C4206F6E',N'TP02',22.00000,514326.00000,11315172.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 394,N'7FA49D95',N'DF663D06',N'A92',82.00000,983900.00000,80679800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 395,N'7FA49D95',N'27E3B6CD',N'HH03',36.00000,114986.00000,4139496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 396,N'7FA49D95',N'96B343CB',N'HH02',100.00000,292952.00000,29295200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 397,N'7FA49D95',N'6753222C',N'HH02',65.00000,380607.00000,24739455.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 398,N'38AFEDA4',N'724333FF',N'TP02',68.00000,968841.00000,65881188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 399,N'38AFEDA4',N'A7520EE3',N'HH03',37.00000,682416.00000,25249392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 400,N'38AFEDA4',N'F5AEBB8D',N'DIESEL',51.00000,903718.00000,46089618.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 401,N'38AFEDA4',N'454C8662',N'TP01',45.00000,980022.00000,44100990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 402,N'0237871E',N'32F99DBE',N'A92',8.00000,962435.00000,7699480.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 403,N'0237871E',N'7646CBFD',N'HH03',70.00000,406494.00000,28454580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 404,N'0237871E',N'4589FBD4',N'NVL01',63.00000,481431.00000,30330153.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 405,N'0237871E',N'938F9033',N'HH03',28.00000,291392.00000,8158976.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 406,N'0237871E',N'07369161',N'NVL02',101.00000,643786.00000,65022386.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 407,N'0F04BFF3',N'9EF91480',N'A95',2.00000,602884.00000,1205768.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 408,N'0F04BFF3',N'95FB037E',N'NVL03',25.00000,1092526.00000,27313150.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 409,N'0F04BFF3',N'471BBED4',N'NVL01',66.00000,271358.00000,17909628.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 410,N'0F04BFF3',N'6B5FBE79',N'A95',85.00000,871681.00000,74092885.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 411,N'9A02ACA1',N'22E37393',N'TP03',73.00000,102687.00000,7496151.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 412,N'9A02ACA1',N'3FA187E4',N'TP02',6.00000,980315.00000,5881890.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 413,N'9A02ACA1',N'07064FA1',N'TP02',48.00000,188517.00000,9048816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 414,N'9A02ACA1',N'6964C375',N'HH03',64.00000,154198.00000,9868672.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 415,N'2B83F7C5',N'7974C76F',N'TP02',85.00000,1008056.00000,85684760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 416,N'2B83F7C5',N'3DA1675F',N'TP02',26.00000,383422.00000,9968972.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 417,N'2B83F7C5',N'6CD2CFF9',N'NVL03',48.00000,808011.00000,38784528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 418,N'2B83F7C5',N'E934E043',N'TP02',63.00000,525392.00000,33099696.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 419,N'1E0ECA16',N'85C1622B',N'TP03',75.00000,541550.00000,40616250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 420,N'1E0ECA16',N'16DA1E60',N'HH03',91.00000,849742.00000,77326522.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 421,N'1E0ECA16',N'D18B8DA0',N'TP02',60.00000,716591.00000,42995460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 422,N'56D55D4B',N'718514EF',N'A95',79.00000,555165.00000,43858035.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 423,N'56D55D4B',N'4C01815E',N'TP02',27.00000,359637.00000,9710199.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 424,N'56D55D4B',N'34BE6221',N'HH02',79.00000,992154.00000,78380166.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 425,N'56D55D4B',N'36BE55C7',N'NVL03',24.00000,150365.00000,3608760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 426,N'56D55D4B',N'D3F66B4F',N'A95',69.00000,946257.00000,65291733.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 427,N'56D55D4B',N'F2BDF6DD',N'TP03',4.00000,412915.00000,1651660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 428,N'AD209980',N'EB808C91',N'HH01',32.00000,896564.00000,28690048.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 429,N'AD209980',N'9D9363BA',N'HH02',75.00000,865406.00000,64905450.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 430,N'AD209980',N'B3A717E7',N'A92',95.00000,988609.00000,93917855.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 431,N'AD209980',N'EBB120F4',N'HH01',72.00000,423422.00000,30486384.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 432,N'F9B33A48',N'31133EE9',N'NVL01',21.00000,394614.00000,8286894.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 433,N'F9B33A48',N'A6387AB1',N'HH03',5.00000,804092.00000,4020460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 434,N'F9B33A48',N'02D7C90D',N'TP03',16.00000,743962.00000,11903392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 435,N'F9B33A48',N'07AF6691',N'HH02',20.00000,1022135.00000,20442700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 436,N'F9B33A48',N'B16F17ED',N'NVL02',70.00000,904330.00000,63303100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 437,N'5F1A2A73',N'C755418E',N'TP03',33.00000,778944.00000,25705152.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 438,N'5F1A2A73',N'8823A4BA',N'HH01',7.00000,486311.00000,3404177.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 439,N'5F1A2A73',N'37F9A623',N'HH02',70.00000,235619.00000,16493330.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 440,N'5F1A2A73',N'9D25571C',N'NVL03',67.00000,140813.00000,9434471.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 441,N'5F1A2A73',N'44074843',N'NVL01',16.00000,841650.00000,13466400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 442,N'152485DD',N'19B5CC31',N'TP01',85.00000,952711.00000,80980435.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 443,N'152485DD',N'69EE8DDD',N'HH01',38.00000,1066987.00000,40545506.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 444,N'B22286B0',N'9BDDC6AD',N'HH03',34.00000,822281.00000,27957554.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 445,N'B22286B0',N'51B75EE2',N'HH03',4.00000,621049.00000,2484196.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 446,N'F76F1C21',N'3072A054',N'TP03',94.00000,178456.00000,16774864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 447,N'E21D94ED',N'F3709565',N'HH01',85.00000,783796.00000,66622660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 448,N'E21D94ED',N'CEF01253',N'TP02',43.00000,545088.00000,23438784.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 449,N'E21D94ED',N'08D63643',N'TP02',22.00000,594963.00000,13089186.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 450,N'E21D94ED',N'E9F29FF3',N'TP02',14.00000,839511.00000,11753154.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 451,N'E21D94ED',N'AC4AB893',N'TP03',4.00000,776081.00000,3104324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 452,N'540A54A4',N'99E4F3BA',N'TP03',35.00000,788050.00000,27581750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 453,N'540A54A4',N'E2D90C0D',N'NVL03',58.00000,865088.00000,50175104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 454,N'540A54A4',N'E4187642',N'NVL02',12.00000,130631.00000,1567572.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 455,N'540A54A4',N'FE7EE9BF',N'NVL01',63.00000,201758.00000,12710754.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 456,N'540A54A4',N'75F1153D',N'TP03',50.00000,347215.00000,17360750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 457,N'2F1B0ED5',N'8C12AB02',N'HH02',88.00000,756600.00000,66580800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 458,N'2F1B0ED5',N'30135C68',N'NVL02',27.00000,224104.00000,6050808.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 459,N'2F1B0ED5',N'2A54B395',N'NVL01',24.00000,623149.00000,14955576.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 460,N'2F1B0ED5',N'F120E743',N'TP02',43.00000,923704.00000,39719272.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 461,N'D9687696',N'5BA14673',N'DIESEL',12.00000,735928.00000,8831136.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 462,N'D9687696',N'8F44518F',N'A92',31.00000,258502.00000,8013562.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 463,N'D9687696',N'F37030A4',N'NVL02',27.00000,472431.00000,12755637.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 464,N'D9687696',N'FD7501EB',N'TP01',46.00000,454919.00000,20926274.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 465,N'D9687696',N'32716D87',N'TP02',95.00000,396502.00000,37667690.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 466,N'D9687696',N'50337524',N'A95',14.00000,252547.00000,3535658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 467,N'9A5226E4',N'5363A157',N'TP03',66.00000,504311.00000,33284526.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 468,N'9A5226E4',N'90C03665',N'A92',6.00000,745844.00000,4475064.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 469,N'9A5226E4',N'4356EE81',N'TP01',79.00000,787360.00000,62201440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 470,N'9A5226E4',N'7F4EA846',N'HH02',71.00000,772196.00000,54825916.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 471,N'BA8FBED0',N'1C213024',N'NVL02',80.00000,600889.00000,48071120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 472,N'BA8FBED0',N'4EA892EE',N'NVL02',9.00000,553455.00000,4981095.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 473,N'89245F82',N'22DDEC51',N'HH02',34.00000,889412.00000,30240008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 474,N'89245F82',N'559B1CD5',N'TP03',59.00000,389886.00000,23003274.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 475,N'89245F82',N'7912F793',N'NVL01',53.00000,1044785.00000,55373605.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 476,N'89245F82',N'C55CB2E8',N'HH02',32.00000,682706.00000,21846592.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 477,N'89245F82',N'2816D610',N'A95',71.00000,494029.00000,35076059.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 478,N'89245F82',N'EBCADC2C',N'TP03',99.00000,415639.00000,41148261.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 479,N'B6A8CF76',N'B871B2FB',N'DIESEL',45.00000,1011351.00000,45510795.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 480,N'B6A8CF76',N'A713F3F1',N'HH03',70.00000,842526.00000,58976820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 481,N'B6A8CF76',N'78DB751A',N'TP01',66.00000,855695.00000,56475870.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 482,N'D130C16F',N'9D43F98C',N'HH01',100.00000,521525.00000,52152500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 483,N'70B4B5DE',N'E8D43BD4',N'HH03',62.00000,439210.00000,27231020.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 484,N'70B4B5DE',N'1D369CE0',N'A92',82.00000,168244.00000,13796008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 485,N'10A544FD',N'FF09ED4E',N'HH02',72.00000,235892.00000,16984224.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 486,N'10A544FD',N'64F0FF2F',N'DIESEL',63.00000,987942.00000,62240346.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 487,N'10A544FD',N'3A6E32D7',N'HH03',7.00000,492916.00000,3450412.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 488,N'87D8A3F1',N'B0959472',N'HH02',95.00000,1047795.00000,99540525.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 489,N'87D8A3F1',N'948C8865',N'HH02',57.00000,708500.00000,40384500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 490,N'87D8A3F1',N'59314AA2',N'HH03',92.00000,325747.00000,29968724.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 491,N'87D8A3F1',N'94F1E8B3',N'A95',11.00000,349035.00000,3839385.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 492,N'4510F319',N'037208C5',N'TP02',75.00000,1077217.00000,80791275.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 493,N'4510F319',N'7AA34AE6',N'NVL01',77.00000,1064393.00000,81958261.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 494,N'4510F319',N'08B36156',N'A95',93.00000,319077.00000,29674161.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 495,N'C190ACCB',N'D57D5E84',N'TP03',34.00000,116785.00000,3970690.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 496,N'C190ACCB',N'534E3543',N'DIESEL',67.00000,811077.00000,54342159.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 497,N'C190ACCB',N'5123F01C',N'NVL02',45.00000,535418.00000,24093810.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 498,N'C190ACCB',N'25FD4378',N'NVL01',55.00000,397724.00000,21874820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 499,N'4B8BC522',N'DBD19AF2',N'NVL03',98.00000,128407.00000,12583886.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 500,N'4B8BC522',N'9FCD659A',N'HH01',62.00000,830727.00000,51505074.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 501,N'4B8BC522',N'89A09F7C',N'HH02',31.00000,272936.00000,8461016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 502,N'4B8BC522',N'D35E4599',N'HH01',97.00000,689029.00000,66835813.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 503,N'4B8BC522',N'E6804B94',N'HH02',83.00000,478325.00000,39700975.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 504,N'4B8BC522',N'1FF25A0E',N'HH03',29.00000,368841.00000,10696389.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 505,N'E5602181',N'0FEC5140',N'NVL03',28.00000,153418.00000,4295704.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 506,N'E5602181',N'D4220658',N'HH03',25.00000,462476.00000,11561900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 507,N'E5602181',N'D1A1E8C9',N'TP03',84.00000,957702.00000,80446968.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 508,N'E5602181',N'A1783E96',N'HH03',5.00000,119286.00000,596430.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 509,N'E5602181',N'C41C9948',N'TP03',35.00000,934528.00000,32708480.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 510,N'69D56745',N'08DCA0F4',N'HH01',75.00000,118242.00000,8868150.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 511,N'69D56745',N'47026EFD',N'NVL01',19.00000,955641.00000,18157179.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 512,N'69D56745',N'C13BD17B',N'A95',62.00000,665473.00000,41259326.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 513,N'38AA608C',N'DE205E03',N'TP03',66.00000,765948.00000,50552568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 514,N'38AA608C',N'5CD34D31',N'DIESEL',13.00000,650325.00000,8454225.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 515,N'38AA608C',N'EAD1666E',N'NVL02',10.00000,420039.00000,4200390.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 516,N'38AA608C',N'29C2C270',N'HH02',46.00000,1093113.00000,50283198.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 517,N'38AA608C',N'AFF50623',N'TP03',24.00000,797159.00000,19131816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 518,N'3DC51B49',N'852B93E9',N'NVL01',1.00000,751662.00000,751662.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 519,N'3DC51B49',N'FE8366E3',N'NVL01',49.00000,193032.00000,9458568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 520,N'3DC51B49',N'C548B64E',N'HH02',101.00000,371382.00000,37509582.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 521,N'3DC51B49',N'43F1A13E',N'NVL01',33.00000,1021819.00000,33720027.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 522,N'3DC51B49',N'1554B0F4',N'NVL02',61.00000,494615.00000,30171515.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 523,N'3DC51B49',N'1DD3C1FE',N'A95',35.00000,319658.00000,11188030.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 524,N'F5EF5E82',N'DAB1F994',N'NVL02',69.00000,401645.00000,27713505.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 525,N'F5EF5E82',N'3DDEF6D9',N'HH02',92.00000,770281.00000,70865852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 526,N'2231AF66',N'C0E79C22',N'DIESEL',26.00000,285440.00000,7421440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 527,N'2231AF66',N'CA5E004E',N'TP01',63.00000,581271.00000,36620073.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 528,N'2231AF66',N'5A6E8CDD',N'NVL01',94.00000,1018693.00000,95757142.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 529,N'2231AF66',N'E31C2106',N'DIESEL',81.00000,598853.00000,48507093.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 530,N'2231AF66',N'34E96F6C',N'HH02',12.00000,531350.00000,6376200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 531,N'40DC9DF8',N'710D1E8A',N'HH03',12.00000,422941.00000,5075292.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 532,N'40DC9DF8',N'1D6DF808',N'HH01',73.00000,980555.00000,71580515.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 533,N'34759C26',N'FAC12CB0',N'HH03',62.00000,198863.00000,12329506.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 534,N'34759C26',N'EC73A7CD',N'NVL03',62.00000,574342.00000,35609204.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 535,N'CDA9A057',N'555D828F',N'TP01',84.00000,712361.00000,59838324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 536,N'CDA9A057',N'84E9A8C4',N'HH02',80.00000,986992.00000,78959360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 537,N'CDA9A057',N'2EAC81B0',N'DIESEL',89.00000,814029.00000,72448581.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 538,N'CDA9A057',N'FFBADEF7',N'TP01',81.00000,1003177.00000,81257337.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 539,N'3037A388',N'42119A48',N'HH02',1.00000,779266.00000,779266.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 540,N'3037A388',N'5074F6D8',N'A92',2.00000,1077267.00000,2154534.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 541,N'3037A388',N'24D5110D',N'A95',63.00000,332195.00000,20928285.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 542,N'3037A388',N'101F6A0E',N'NVL02',8.00000,474550.00000,3796400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 543,N'3037A388',N'91CF429B',N'HH02',47.00000,843861.00000,39661467.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 544,N'5A1CBE4D',N'30579E67',N'TP01',94.00000,313176.00000,29438544.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 545,N'5A1CBE4D',N'37B434E1',N'NVL01',12.00000,1011771.00000,12141252.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 546,N'5A1CBE4D',N'18B85CC3',N'HH03',57.00000,583565.00000,33263205.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 547,N'5A1CBE4D',N'17F5B405',N'HH02',27.00000,223050.00000,6022350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 548,N'3156AFE8',N'FA51033D',N'TP02',16.00000,721924.00000,11550784.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 549,N'3156AFE8',N'5D721EA6',N'HH01',34.00000,989298.00000,33636132.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 550,N'3156AFE8',N'8AB4350E',N'HH01',49.00000,288557.00000,14139293.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 551,N'3156AFE8',N'6CF4E01E',N'TP03',73.00000,224489.00000,16387697.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 552,N'3156AFE8',N'F9D584DA',N'HH03',23.00000,153439.00000,3529097.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 553,N'D21F5DD4',N'44CF9D54',N'TP03',90.00000,728566.00000,65570940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 554,N'D21F5DD4',N'18C0F402',N'DIESEL',22.00000,283314.00000,6232908.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 555,N'EE5B3A05',N'4600B3AB',N'TP02',61.00000,927447.00000,56574267.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 556,N'EE5B3A05',N'E1858942',N'A95',33.00000,827793.00000,27317169.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 557,N'EE5B3A05',N'98682BB3',N'TP02',22.00000,682020.00000,15004440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 558,N'EE5B3A05',N'AA165BC7',N'A95',67.00000,161799.00000,10840533.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 559,N'EE5B3A05',N'8F3F4AE2',N'A95',73.00000,157745.00000,11515385.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 560,N'EE5B3A05',N'BED6AAD0',N'TP02',97.00000,951195.00000,92265915.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 561,N'2AC0A53C',N'A296C742',N'TP03',43.00000,668287.00000,28736341.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 562,N'2AC0A53C',N'776B24E0',N'HH01',44.00000,387531.00000,17051364.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 563,N'FFE2CFFF',N'72C1ED76',N'HH03',77.00000,399822.00000,30786294.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 564,N'FFE2CFFF',N'98E0CF95',N'TP03',26.00000,274024.00000,7124624.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 565,N'FFE2CFFF',N'B16C63E9',N'TP01',49.00000,1088026.00000,53313274.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 566,N'FFE2CFFF',N'869885AF',N'HH02',68.00000,940308.00000,63940944.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 567,N'FFE2CFFF',N'F8E6C419',N'A95',97.00000,613619.00000,59521043.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 568,N'FFE2CFFF',N'5FC47E35',N'NVL03',15.00000,419205.00000,6288075.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 569,N'FBA4F0E3',N'B5DB301A',N'NVL03',75.00000,600975.00000,45073125.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 570,N'A03ED31E',N'AC74D663',N'TP02',85.00000,332521.00000,28264285.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 571,N'A03ED31E',N'E6AA11AA',N'HH02',17.00000,917600.00000,15599200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 572,N'A03ED31E',N'100C7466',N'A92',3.00000,786838.00000,2360514.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 573,N'A03ED31E',N'0B620798',N'TP02',88.00000,524908.00000,46191904.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 574,N'CA5A4EFF',N'6AAC3835',N'A95',17.00000,413227.00000,7024859.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 575,N'CA5A4EFF',N'FB64E952',N'HH02',87.00000,215133.00000,18716571.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 576,N'CA5A4EFF',N'9DDB7B47',N'TP02',71.00000,873062.00000,61987402.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 577,N'CA5A4EFF',N'F25459C7',N'A92',92.00000,211593.00000,19466556.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 578,N'CA5A4EFF',N'211F750A',N'HH01',73.00000,676194.00000,49362162.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 579,N'9092E2EB',N'1DFC71B5',N'TP03',40.00000,524836.00000,20993440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 580,N'9092E2EB',N'186813C0',N'NVL03',85.00000,453556.00000,38552260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 581,N'9092E2EB',N'AC63EEE5',N'TP03',15.00000,741585.00000,11123775.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 582,N'DE8F6AC5',N'06207572',N'DIESEL',37.00000,655663.00000,24259531.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 583,N'DE8F6AC5',N'BA5B8BE0',N'HH03',16.00000,589368.00000,9429888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 584,N'DE8F6AC5',N'C64DCAF3',N'NVL01',65.00000,312632.00000,20321080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 585,N'DE8F6AC5',N'2AF0E257',N'NVL01',52.00000,329297.00000,17123444.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 586,N'DE8F6AC5',N'A9D38292',N'HH03',8.00000,500563.00000,4004504.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 587,N'F4BAD413',N'31B3ADEA',N'HH01',46.00000,581096.00000,26730416.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 588,N'F4BAD413',N'FFD062B3',N'NVL03',13.00000,126728.00000,1647464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 589,N'F4BAD413',N'063EE52F',N'A95',57.00000,915289.00000,52171473.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 590,N'3758036D',N'87AC6599',N'NVL02',51.00000,405646.00000,20687946.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 591,N'3758036D',N'46F22691',N'HH02',55.00000,1073100.00000,59020500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 592,N'3758036D',N'1522799C',N'A92',88.00000,318226.00000,28003888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 593,N'7275F192',N'651DE6B9',N'HH02',55.00000,263920.00000,14515600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 594,N'7275F192',N'BF300D6F',N'TP03',72.00000,164852.00000,11869344.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 595,N'84EF8F31',N'500970BF',N'A95',63.00000,283222.00000,17842986.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 596,N'84EF8F31',N'C7CD6AFB',N'NVL02',73.00000,931989.00000,68035197.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 597,N'1499E245',N'E8A9E360',N'HH02',30.00000,505953.00000,15178590.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 598,N'1499E245',N'A223EE91',N'HH03',69.00000,240969.00000,16626861.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 599,N'D1952185',N'E6F317AB',N'NVL01',98.00000,356004.00000,34888392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 600,N'D1952185',N'332362F3',N'TP03',28.00000,656711.00000,18387908.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 601,N'C0FC0F8D',N'14804584',N'TP02',61.00000,990918.00000,60445998.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 602,N'C0FC0F8D',N'A50C0FC3',N'HH02',76.00000,808173.00000,61421148.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 603,N'C0FC0F8D',N'6C537B1A',N'TP01',89.00000,893456.00000,79517584.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 604,N'C0FC0F8D',N'9D60CCD0',N'HH02',40.00000,118506.00000,4740240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 605,N'C0FC0F8D',N'4FD3CC65',N'HH02',54.00000,413610.00000,22334940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 606,N'5A213F01',N'25BA394F',N'A92',33.00000,388782.00000,12829806.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 607,N'5A213F01',N'DAB2AEF7',N'NVL03',55.00000,736355.00000,40499525.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 608,N'5A213F01',N'8D9D1AF0',N'TP01',13.00000,668797.00000,8694361.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 609,N'5A213F01',N'41510892',N'DIESEL',12.00000,245091.00000,2941092.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 610,N'DDD9690C',N'D26C44A4',N'A95',63.00000,738724.00000,46539612.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 611,N'DDD9690C',N'CF79A498',N'HH03',11.00000,416017.00000,4576187.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 612,N'DDD9690C',N'A28BB28C',N'TP02',15.00000,543535.00000,8153025.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 613,N'E8AD9B82',N'BCC3CD3E',N'HH02',20.00000,238611.00000,4772220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 614,N'7DB68487',N'0B1BEE37',N'HH03',84.00000,841744.00000,70706496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 615,N'7DB68487',N'6EE416DA',N'A92',53.00000,174955.00000,9272615.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 616,N'7DB68487',N'C97D79BB',N'A95',48.00000,732290.00000,35149920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 617,N'7DB68487',N'E6F60F62',N'HH02',46.00000,1085712.00000,49942752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 618,N'7DB68487',N'91D92053',N'HH01',65.00000,135524.00000,8809060.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 619,N'8A9A9644',N'B07F6E80',N'NVL02',54.00000,424440.00000,22919760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 620,N'8A9A9644',N'1BAA8E5A',N'TP01',53.00000,743110.00000,39384830.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 621,N'8A9A9644',N'9944A59D',N'NVL02',100.00000,262382.00000,26238200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 622,N'8A9A9644',N'4D0BED47',N'A95',73.00000,361097.00000,26360081.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 623,N'85D56620',N'521CD4BA',N'NVL01',5.00000,707341.00000,3536705.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 624,N'85D56620',N'75018958',N'A92',47.00000,903242.00000,42452374.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 625,N'85D56620',N'34C1FE06',N'HH02',31.00000,1000068.00000,31002108.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 626,N'28F3E169',N'492D7EA1',N'NVL02',15.00000,196031.00000,2940465.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 627,N'28F3E169',N'68BB2872',N'HH03',45.00000,692330.00000,31154850.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 628,N'28F3E169',N'A46B8353',N'TP01',87.00000,732344.00000,63713928.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 629,N'28F3E169',N'193A066E',N'HH01',76.00000,585074.00000,44465624.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 630,N'28F3E169',N'AFF0E35E',N'TP01',44.00000,759039.00000,33397716.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 631,N'28F3E169',N'80DBE982',N'NVL02',30.00000,708183.00000,21245490.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 632,N'1263939D',N'876F4ED8',N'NVL02',48.00000,155219.00000,7450512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 633,N'1263939D',N'BE0526B0',N'A92',26.00000,1032854.00000,26854204.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 634,N'1263939D',N'33937B2F',N'TP02',63.00000,451404.00000,28438452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 635,N'1263939D',N'D8388FD4',N'TP01',87.00000,963374.00000,83813538.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 636,N'BDFFDC59',N'6EED1C2B',N'TP03',12.00000,419571.00000,5034852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 637,N'BDFFDC59',N'64B1590D',N'A92',87.00000,200353.00000,17430711.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 638,N'BDFFDC59',N'A9EDCC89',N'NVL03',87.00000,644443.00000,56066541.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 639,N'BDFFDC59',N'185E4EA4',N'A92',1.00000,314608.00000,314608.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 640,N'BDFFDC59',N'DE0FA349',N'TP01',40.00000,100399.00000,4015960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 641,N'B007A8B5',N'3F34F769',N'HH02',15.00000,309685.00000,4645275.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 642,N'B007A8B5',N'E57CBD12',N'HH03',74.00000,639729.00000,47339946.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 643,N'B007A8B5',N'5FD93E74',N'HH02',77.00000,306122.00000,23571394.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 644,N'4DE244BD',N'C8FC9AEC',N'TP01',19.00000,402161.00000,7641059.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 645,N'4DE244BD',N'056A58FE',N'A92',86.00000,390103.00000,33548858.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 646,N'4DE244BD',N'7D4C159F',N'TP01',86.00000,997751.00000,85806586.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 647,N'4DE244BD',N'9D5AEB66',N'HH01',39.00000,590409.00000,23025951.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 648,N'4DE244BD',N'0B56E623',N'TP03',3.00000,106487.00000,319461.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 649,N'4DE244BD',N'ADED2E04',N'TP01',71.00000,1017429.00000,72237459.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 650,N'F72864EC',N'8A5676E7',N'TP03',76.00000,486109.00000,36944284.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 651,N'F72864EC',N'8E90A48B',N'A95',22.00000,364121.00000,8010662.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 652,N'F72864EC',N'BC2B5083',N'TP01',52.00000,741630.00000,38564760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 653,N'F72864EC',N'AA3AE4C6',N'NVL01',85.00000,802211.00000,68187935.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 654,N'F72864EC',N'B2250840',N'HH03',29.00000,931665.00000,27018285.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 655,N'EFADD91C',N'AD1BC1FD',N'TP03',38.00000,854110.00000,32456180.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 656,N'EFADD91C',N'8C817A63',N'NVL02',88.00000,1075615.00000,94654120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 657,N'CA0BE653',N'766831A2',N'A95',80.00000,1047886.00000,83830880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 658,N'CA0BE653',N'F3228014',N'TP02',36.00000,463320.00000,16679520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 659,N'CA0BE653',N'15AB8BC3',N'NVL02',49.00000,689142.00000,33767958.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 660,N'BF15A933',N'A641F7C4',N'A95',52.00000,974688.00000,50683776.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 661,N'BF15A933',N'6D93AE67',N'TP02',19.00000,179761.00000,3415459.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 662,N'BF15A933',N'BACBE72C',N'A92',97.00000,943941.00000,91562277.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 663,N'BF15A933',N'DA990427',N'NVL03',63.00000,310132.00000,19538316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 664,N'BF15A933',N'336FA531',N'TP01',1.00000,596060.00000,596060.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 665,N'BF15A933',N'1A6ACBE9',N'NVL03',98.00000,186406.00000,18267788.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 666,N'4CA089BD',N'8912B609',N'HH02',66.00000,581747.00000,38395302.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 667,N'4CA089BD',N'FB321856',N'HH02',44.00000,667057.00000,29350508.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 668,N'9A911770',N'7ECDEE59',N'TP01',96.00000,151098.00000,14505408.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 669,N'9A911770',N'6E937ECE',N'HH01',7.00000,509104.00000,3563728.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 670,N'9A911770',N'57820C1D',N'HH02',65.00000,367247.00000,23871055.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 671,N'9A911770',N'7A0A22D6',N'NVL02',75.00000,156329.00000,11724675.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 672,N'9A911770',N'0BA7D90C',N'HH01',28.00000,493599.00000,13820772.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 673,N'B7B04FCF',N'A0AFA1F0',N'TP03',7.00000,242859.00000,1700013.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 674,N'B7B04FCF',N'A12F3332',N'TP02',50.00000,666487.00000,33324350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 675,N'B7B04FCF',N'65FC2B4F',N'TP03',91.00000,248771.00000,22638161.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 676,N'B7B04FCF',N'E30098E2',N'A92',22.00000,345726.00000,7605972.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 677,N'0202EF97',N'331BFD28',N'NVL03',97.00000,930176.00000,90227072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 678,N'0202EF97',N'97C94141',N'TP03',45.00000,205634.00000,9253530.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 679,N'0202EF97',N'A2D88E5D',N'HH01',96.00000,136315.00000,13086240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 680,N'0202EF97',N'0273A011',N'TP02',35.00000,765205.00000,26782175.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 681,N'AF189DCC',N'5240FC57',N'A92',45.00000,182504.00000,8212680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 682,N'AF189DCC',N'B86BEA5B',N'A92',57.00000,248755.00000,14179035.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 683,N'E44D4AF4',N'F05CA6DC',N'A95',17.00000,672775.00000,11437175.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 684,N'E44D4AF4',N'BCEB52C6',N'A92',11.00000,137696.00000,1514656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 685,N'E44D4AF4',N'9C8E541B',N'A92',79.00000,158014.00000,12483106.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 686,N'E44D4AF4',N'1B88B5C0',N'NVL01',89.00000,499009.00000,44411801.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 687,N'0F85BAF6',N'10453C83',N'HH03',38.00000,524628.00000,19935864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 688,N'C1F602B1',N'DA891309',N'HH01',42.00000,130219.00000,5469198.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 689,N'C1F602B1',N'0AEEB9D5',N'TP02',28.00000,959284.00000,26859952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 690,N'676E7EB3',N'C51FE688',N'HH03',43.00000,559696.00000,24066928.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 691,N'676E7EB3',N'C64616E1',N'DIESEL',17.00000,336409.00000,5718953.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 692,N'676E7EB3',N'A74C427E',N'HH01',11.00000,1011592.00000,11127512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 693,N'676E7EB3',N'1640793E',N'TP03',56.00000,583508.00000,32676448.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 694,N'676E7EB3',N'91398175',N'TP03',66.00000,476583.00000,31454478.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 695,N'C9A414FA',N'37B5C838',N'HH03',91.00000,940864.00000,85618624.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 696,N'C9A414FA',N'B84FA766',N'NVL03',100.00000,920575.00000,92057500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 697,N'C9A414FA',N'A5A11277',N'TP03',47.00000,389688.00000,18315336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 698,N'C9A414FA',N'412F4BF7',N'TP03',23.00000,711101.00000,16355323.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 699,N'C9A414FA',N'AA0961F2',N'HH02',85.00000,121148.00000,10297580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 700,N'6A24EDBE',N'69614860',N'NVL01',90.00000,1042956.00000,93866040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 701,N'6A24EDBE',N'1B149C6F',N'DIESEL',97.00000,838924.00000,81375628.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 702,N'6A24EDBE',N'BCD4C46A',N'A95',23.00000,964920.00000,22193160.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 703,N'1890D0D7',N'9E4E6BF3',N'TP01',29.00000,345034.00000,10005986.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 704,N'1890D0D7',N'699AFEDE',N'HH01',12.00000,520881.00000,6250572.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 705,N'1890D0D7',N'BA68B429',N'NVL03',13.00000,989654.00000,12865502.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 706,N'8DCF484B',N'34DF32CB',N'HH02',6.00000,581809.00000,3490854.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 707,N'8DCF484B',N'A7497123',N'A92',12.00000,152155.00000,1825860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 708,N'7CC0BE4C',N'AA6B33A0',N'TP01',17.00000,981536.00000,16686112.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 709,N'7CC0BE4C',N'A39D23FD',N'NVL03',32.00000,349846.00000,11195072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 710,N'E199DF22',N'81C308A1',N'DIESEL',44.00000,383540.00000,16875760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 711,N'E199DF22',N'D4C9A9F5',N'NVL02',53.00000,731929.00000,38792237.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 712,N'E199DF22',N'1E4DD405',N'HH03',79.00000,779780.00000,61602620.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 713,N'E199DF22',N'2A5DB308',N'HH02',20.00000,932958.00000,18659160.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 714,N'4A6E16A5',N'A8928C42',N'HH03',67.00000,656701.00000,43998967.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 715,N'4A6E16A5',N'1DDB8FDB',N'TP01',40.00000,159678.00000,6387120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 716,N'9552E45A',N'E69BF43B',N'NVL02',84.00000,812969.00000,68289396.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 717,N'9552E45A',N'7A88241A',N'TP03',4.00000,205654.00000,822616.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 718,N'9552E45A',N'FDFF7184',N'HH01',25.00000,234429.00000,5860725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 719,N'9552E45A',N'997A072D',N'A92',19.00000,286090.00000,5435710.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 720,N'9552E45A',N'8EE344F0',N'TP02',60.00000,586061.00000,35163660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 721,N'9552E45A',N'53C7BC81',N'NVL01',66.00000,257201.00000,16975266.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 722,N'F06AF903',N'2F31783A',N'DIESEL',93.00000,639890.00000,59509770.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 723,N'F06AF903',N'B1ADA7E8',N'HH01',51.00000,891878.00000,45485778.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 724,N'F06AF903',N'94888D5C',N'A95',38.00000,772248.00000,29345424.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 725,N'F06AF903',N'236694D3',N'A95',75.00000,479556.00000,35966700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 726,N'D762FB5A',N'C1ECF7D3',N'A95',58.00000,946183.00000,54878614.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 727,N'D762FB5A',N'5859C27B',N'DIESEL',41.00000,161302.00000,6613382.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 728,N'D762FB5A',N'677B49F1',N'HH01',81.00000,557962.00000,45194922.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 729,N'D762FB5A',N'D5B0BF0B',N'HH03',5.00000,532016.00000,2660080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 730,N'D762FB5A',N'F3873DF8',N'HH02',47.00000,856173.00000,40240131.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 731,N'D762FB5A',N'6B3A7982',N'TP02',34.00000,831804.00000,28281336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 732,N'79C70457',N'6F1D42A7',N'HH02',91.00000,151138.00000,13753558.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 733,N'79C70457',N'65373235',N'NVL03',68.00000,976369.00000,66393092.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 734,N'79C70457',N'2B090413',N'NVL03',65.00000,890618.00000,57890170.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 735,N'EA01D9B2',N'CBF606DA',N'TP02',92.00000,769153.00000,70762076.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 736,N'362B7CA9',N'A996926F',N'A95',1.00000,491055.00000,491055.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 737,N'362B7CA9',N'B09CB8EB',N'A92',14.00000,258204.00000,3614856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 738,N'362B7CA9',N'B045A7E1',N'A95',15.00000,585338.00000,8780070.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 739,N'362B7CA9',N'7B999722',N'A95',89.00000,792910.00000,70568990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 740,N'362B7CA9',N'FC328035',N'TP03',4.00000,153258.00000,613032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 741,N'362B7CA9',N'FDD48667',N'HH01',91.00000,349677.00000,31820607.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 742,N'7F7F9055',N'9AF730C1',N'DIESEL',63.00000,437032.00000,27533016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 743,N'7F7F9055',N'B34FC853',N'HH03',42.00000,411505.00000,17283210.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 744,N'7F7F9055',N'63DA12BF',N'TP01',86.00000,1012493.00000,87074398.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 745,N'7F7F9055',N'15B9D43C',N'NVL03',60.00000,1033492.00000,62009520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 746,N'7F7F9055',N'FCDC23AB',N'A95',67.00000,567071.00000,37993757.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 747,N'7F7F9055',N'EA738905',N'HH01',66.00000,788867.00000,52065222.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 748,N'0E999483',N'474DBA58',N'HH02',99.00000,127245.00000,12597255.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 749,N'0E999483',N'A579DDC6',N'DIESEL',81.00000,969598.00000,78537438.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 750,N'0E999483',N'60CC3B80',N'HH01',2.00000,331485.00000,662970.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 751,N'4340BF7C',N'F4A2366A',N'HH01',86.00000,1076576.00000,92585536.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 752,N'4340BF7C',N'754A750A',N'TP03',80.00000,474042.00000,37923360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 753,N'4340BF7C',N'51D5D47F',N'NVL02',37.00000,829887.00000,30705819.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 754,N'4340BF7C',N'011F334E',N'TP02',78.00000,238236.00000,18582408.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 755,N'4340BF7C',N'D21F9B12',N'TP03',43.00000,625981.00000,26917183.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 756,N'4340BF7C',N'C54D6B97',N'TP01',50.00000,204925.00000,10246250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 757,N'BE497B0A',N'B54B703B',N'HH01',65.00000,399199.00000,25947935.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 758,N'BE497B0A',N'FEB940AE',N'TP01',56.00000,956802.00000,53580912.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 759,N'BE497B0A',N'CA30EE38',N'DIESEL',4.00000,720046.00000,2880184.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 760,N'BE497B0A',N'ABDDB701',N'HH02',6.00000,554554.00000,3327324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 761,N'BE497B0A',N'2CD2FF8C',N'HH01',49.00000,658035.00000,32243715.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 762,N'1462825A',N'17EB4FD7',N'DIESEL',31.00000,264441.00000,8197671.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 763,N'1462825A',N'35844AAC',N'NVL02',94.00000,1040052.00000,97764888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 764,N'1462825A',N'D8C044ED',N'HH03',55.00000,816628.00000,44914540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 765,N'1462825A',N'7F7F0D0C',N'TP02',24.00000,249059.00000,5977416.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 766,N'8A376D83',N'D7030E74',N'DIESEL',94.00000,701128.00000,65906032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 767,N'8A376D83',N'72C4E06A',N'HH03',26.00000,354035.00000,9204910.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 768,N'8A376D83',N'05A87DE9',N'HH01',50.00000,528149.00000,26407450.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 769,N'8A376D83',N'C15571A0',N'HH03',72.00000,254701.00000,18338472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 770,N'8A376D83',N'D8C3A810',N'NVL01',76.00000,758297.00000,57630572.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 771,N'55FE9EA5',N'2D6811FE',N'TP01',63.00000,776037.00000,48890331.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 772,N'55FE9EA5',N'5B7FE627',N'TP02',101.00000,696033.00000,70299333.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 773,N'55FE9EA5',N'4AB6534A',N'HH02',86.00000,920767.00000,79185962.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 774,N'7123AC69',N'2597E402',N'HH03',94.00000,242799.00000,22823106.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 775,N'7123AC69',N'6336A622',N'NVL02',2.00000,965200.00000,1930400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 776,N'7123AC69',N'0F89697A',N'A92',7.00000,581974.00000,4073818.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 777,N'7123AC69',N'F82DD358',N'HH01',64.00000,833712.00000,53357568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 778,N'B77BD0BF',N'730BD6C2',N'HH02',86.00000,787797.00000,67750542.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 779,N'B77BD0BF',N'D7531CD1',N'NVL02',70.00000,239517.00000,16766190.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 780,N'F33D3460',N'C8FCB55C',N'A92',39.00000,437859.00000,17076501.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 781,N'1E527A26',N'F8D64C9B',N'HH03',38.00000,980661.00000,37265118.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 782,N'1E527A26',N'75C214C4',N'A95',43.00000,848092.00000,36467956.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 783,N'89B0898E',N'093DBE51',N'TP03',58.00000,1049925.00000,60895650.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 784,N'89B0898E',N'88D166BC',N'TP02',31.00000,1056470.00000,32750570.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 785,N'89B0898E',N'4A00F1AB',N'TP02',84.00000,384554.00000,32302536.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 786,N'89B0898E',N'DE5E2784',N'NVL02',37.00000,835660.00000,30919420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 787,N'A90D63F7',N'23625140',N'HH03',59.00000,891651.00000,52607409.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 788,N'A90D63F7',N'C09B8DE6',N'NVL01',82.00000,329328.00000,27004896.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 789,N'A90D63F7',N'3053C8E3',N'HH01',88.00000,656346.00000,57758448.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 790,N'A90D63F7',N'FD372232',N'TP01',26.00000,819685.00000,21311810.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 791,N'0B957E7D',N'6E855864',N'TP01',87.00000,876421.00000,76248627.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 792,N'0B957E7D',N'D97BF3EC',N'A95',73.00000,218804.00000,15972692.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 793,N'0B957E7D',N'11134B29',N'DIESEL',61.00000,853292.00000,52050812.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 794,N'0B957E7D',N'63D48363',N'HH02',71.00000,421112.00000,29898952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 795,N'0B957E7D',N'B14E12E3',N'TP01',98.00000,161331.00000,15810438.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 796,N'0B957E7D',N'FED3E2D2',N'TP03',75.00000,775171.00000,58137825.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 797,N'20B22ACB',N'45C151D7',N'DIESEL',32.00000,1009709.00000,32310688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 798,N'20B22ACB',N'CBC2F9DB',N'TP01',53.00000,907956.00000,48121668.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 799,N'20B22ACB',N'A94AC283',N'HH01',9.00000,1024444.00000,9219996.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 800,N'10753E07',N'7DEE0A0C',N'TP02',63.00000,487136.00000,30689568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 801,N'10753E07',N'CFF912FF',N'HH01',62.00000,713612.00000,44243944.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 802,N'10753E07',N'38D46F11',N'NVL03',25.00000,988222.00000,24705550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 803,N'27DD96E7',N'071B6214',N'TP01',101.00000,618951.00000,62514051.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 804,N'27DD96E7',N'27527AED',N'TP01',48.00000,727730.00000,34931040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 805,N'27DD96E7',N'6027FD6C',N'A95',43.00000,1029455.00000,44266565.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 806,N'B5689959',N'2A75346A',N'TP01',79.00000,905063.00000,71499977.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 807,N'92E41D90',N'678C1D53',N'A95',80.00000,705657.00000,56452560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 808,N'92E41D90',N'EDDD0072',N'NVL03',60.00000,633863.00000,38031780.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 809,N'92E41D90',N'100C61FD',N'TP02',70.00000,272542.00000,19077940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 810,N'7A70E960',N'FE119255',N'A92',41.00000,341001.00000,13981041.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 811,N'7A70E960',N'E912526F',N'A95',11.00000,890362.00000,9793982.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 812,N'C248AE9D',N'B7EBFB6B',N'A95',64.00000,549588.00000,35173632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 813,N'C248AE9D',N'EC51D757',N'NVL02',24.00000,482280.00000,11574720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 814,N'8585F6C0',N'8A0B28EC',N'HH02',19.00000,1082793.00000,20573067.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 815,N'8585F6C0',N'7A4A15A8',N'NVL01',68.00000,301625.00000,20510500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 816,N'8585F6C0',N'74549D09',N'DIESEL',64.00000,880450.00000,56348800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 817,N'8585F6C0',N'A6B23129',N'TP02',41.00000,377560.00000,15479960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 818,N'8585F6C0',N'B63E1C6A',N'DIESEL',69.00000,794827.00000,54843063.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 819,N'905F4439',N'B1F86528',N'TP03',56.00000,921147.00000,51584232.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 820,N'905F4439',N'B51B37C9',N'TP03',15.00000,620533.00000,9307995.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 821,N'905F4439',N'3BEC3DC0',N'TP01',1.00000,211596.00000,211596.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 822,N'905F4439',N'C7A6CA66',N'NVL02',57.00000,726218.00000,41394426.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 823,N'905F4439',N'237FA847',N'TP01',19.00000,785909.00000,14932271.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 824,N'905F4439',N'6DF14129',N'A92',5.00000,537547.00000,2687735.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 825,N'E282DDD5',N'D3D9D6F6',N'TP01',5.00000,794115.00000,3970575.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 826,N'E282DDD5',N'3779CC98',N'A95',88.00000,367574.00000,32346512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 827,N'E282DDD5',N'49529F18',N'A95',68.00000,901509.00000,61302612.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 828,N'E282DDD5',N'FF8F4B1F',N'NVL02',6.00000,490843.00000,2945058.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 829,N'F668CA2C',N'C99DDA8A',N'TP02',57.00000,714978.00000,40753746.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 830,N'F668CA2C',N'84FA7480',N'TP02',62.00000,677209.00000,41986958.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 831,N'F668CA2C',N'A3F56E72',N'A92',91.00000,1065017.00000,96916547.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 832,N'F668CA2C',N'46D805ED',N'TP02',71.00000,786573.00000,55846683.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 833,N'F00367AD',N'69472D49',N'NVL01',97.00000,953437.00000,92483389.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 834,N'F00367AD',N'9EF444E6',N'NVL03',54.00000,470996.00000,25433784.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 835,N'6D735588',N'5F152278',N'NVL02',33.00000,898134.00000,29638422.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 836,N'6D735588',N'318A1CC1',N'NVL02',23.00000,402295.00000,9252785.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 837,N'212085F9',N'24050CE8',N'TP01',22.00000,323965.00000,7127230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 838,N'212085F9',N'472C44ED',N'HH03',96.00000,883538.00000,84819648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 839,N'212085F9',N'46B16F83',N'HH02',6.00000,673434.00000,4040604.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 840,N'38E74814',N'D4978055',N'HH03',67.00000,301992.00000,20233464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 841,N'38E74814',N'BA20C64C',N'TP02',67.00000,860853.00000,57677151.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 842,N'38E74814',N'5F4660D0',N'A92',71.00000,318743.00000,22630753.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 843,N'38E74814',N'F6FD6ADD',N'NVL03',72.00000,246214.00000,17727408.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 844,N'7510AAD7',N'36233A22',N'NVL02',48.00000,844210.00000,40522080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 845,N'DEBCE20D',N'E6BF23FF',N'TP02',57.00000,769465.00000,43859505.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 846,N'DEBCE20D',N'76DD7040',N'DIESEL',93.00000,623348.00000,57971364.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 847,N'DEBCE20D',N'8982887D',N'TP01',61.00000,650703.00000,39692883.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 848,N'DEBCE20D',N'B268F734',N'DIESEL',82.00000,651908.00000,53456456.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 849,N'DEBCE20D',N'C658BC70',N'NVL03',93.00000,1092103.00000,101565579.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 850,N'DEBCE20D',N'EA3088BD',N'NVL03',76.00000,1019502.00000,77482152.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 851,N'CA9CD94D',N'767FE093',N'A92',82.00000,328058.00000,26900756.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 852,N'CA9CD94D',N'CFA66486',N'HH02',22.00000,763210.00000,16790620.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 853,N'CA9CD94D',N'21E1BDF0',N'NVL01',50.00000,310498.00000,15524900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 854,N'CA9CD94D',N'1B1F7AB2',N'A92',57.00000,246316.00000,14040012.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 855,N'CA9CD94D',N'04CF12D7',N'TP02',93.00000,913732.00000,84977076.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 856,N'C866D004',N'4E2DDD44',N'NVL03',35.00000,755944.00000,26458040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 857,N'C866D004',N'57982548',N'A92',85.00000,485456.00000,41263760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 858,N'C866D004',N'713733A3',N'TP03',98.00000,1060655.00000,103944190.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 859,N'C866D004',N'14402404',N'DIESEL',35.00000,829012.00000,29015420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 860,N'D55F4CA9',N'001BDCB4',N'A95',33.00000,640761.00000,21145113.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 861,N'D55F4CA9',N'9B4264BE',N'A92',41.00000,988879.00000,40544039.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 862,N'D55F4CA9',N'B19361BB',N'NVL01',54.00000,312206.00000,16859124.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 863,N'69313CE2',N'7E85E339',N'TP03',24.00000,813712.00000,19529088.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 864,N'69313CE2',N'59C8087F',N'A92',10.00000,316531.00000,3165310.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 865,N'69313CE2',N'85926220',N'A92',4.00000,500276.00000,2001104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 866,N'69313CE2',N'7766CA91',N'A95',61.00000,259431.00000,15825291.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 867,N'69313CE2',N'8CB5CDE0',N'TP01',37.00000,642137.00000,23759069.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 868,N'BB86F663',N'A6973EF6',N'NVL03',75.00000,228730.00000,17154750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 869,N'BB86F663',N'AB9EF960',N'HH02',2.00000,272815.00000,545630.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 870,N'BB86F663',N'41333A13',N'A92',35.00000,387033.00000,13546155.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 871,N'BB86F663',N'4F3F27B0',N'HH03',4.00000,207154.00000,828616.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 872,N'BB86F663',N'CBFD5756',N'NVL03',42.00000,876229.00000,36801618.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 873,N'0B99AE86',N'0D02EC00',N'NVL02',100.00000,961862.00000,96186200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 874,N'0B99AE86',N'3FE956C7',N'NVL02',62.00000,459288.00000,28475856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 875,N'0B99AE86',N'2FCF310F',N'HH01',56.00000,153834.00000,8614704.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 876,N'25616269',N'A2B9C183',N'TP03',78.00000,1000231.00000,78018018.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 877,N'25616269',N'4266A080',N'TP03',80.00000,643687.00000,51494960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 878,N'6A4DABF8',N'9A30B073',N'TP03',87.00000,423195.00000,36817965.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 879,N'2BBA5DA2',N'3F7DED31',N'TP03',74.00000,417669.00000,30907506.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 880,N'2BBA5DA2',N'D7ADBC02',N'TP01',3.00000,181218.00000,543654.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 881,N'2BBA5DA2',N'72B96465',N'HH01',40.00000,578950.00000,23158000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 882,N'2BBA5DA2',N'9A23B5C0',N'HH03',41.00000,719189.00000,29486749.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 883,N'E5EEA677',N'A824C47D',N'DIESEL',92.00000,246792.00000,22704864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 884,N'E5EEA677',N'0818853D',N'HH03',86.00000,430600.00000,37031600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 885,N'E5EEA677',N'63C2C0E1',N'NVL03',60.00000,630916.00000,37854960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 886,N'E5EEA677',N'FBAE9352',N'TP02',50.00000,193808.00000,9690400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 887,N'E5EEA677',N'92080E01',N'TP02',55.00000,582763.00000,32051965.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 888,N'E5EEA677',N'331858EF',N'DIESEL',64.00000,464324.00000,29716736.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 889,N'C9527695',N'A59D0E57',N'NVL02',24.00000,911146.00000,21867504.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 890,N'C9527695',N'2C4E7D4E',N'A95',48.00000,999659.00000,47983632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 891,N'C9527695',N'DB1C86FC',N'HH03',24.00000,953003.00000,22872072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 892,N'C9527695',N'DF0AFFC0',N'NVL01',44.00000,950722.00000,41831768.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 893,N'C9527695',N'3111F055',N'NVL02',57.00000,181114.00000,10323498.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 894,N'B755343A',N'A420CD4D',N'HH02',51.00000,1060210.00000,54070710.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 895,N'B755343A',N'710DC5EE',N'HH01',99.00000,181958.00000,18013842.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 896,N'B755343A',N'422E71FB',N'NVL02',27.00000,1089062.00000,29404674.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 897,N'68D9D589',N'EBF08EE1',N'A95',52.00000,1031893.00000,53658436.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 898,N'68D9D589',N'FA11C627',N'TP02',5.00000,657968.00000,3289840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 899,N'68D9D589',N'D1119713',N'HH03',72.00000,766399.00000,55180728.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 900,N'68D9D589',N'E0A8928C',N'TP01',64.00000,455773.00000,29169472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 901,N'68D9D589',N'3031AE24',N'DIESEL',18.00000,351592.00000,6328656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 902,N'64741A1C',N'B83E690C',N'NVL02',48.00000,998908.00000,47947584.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 903,N'64741A1C',N'7813110A',N'TP02',17.00000,907051.00000,15419867.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 904,N'64741A1C',N'A2D7BF87',N'NVL03',61.00000,818928.00000,49954608.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 905,N'64741A1C',N'71DA652C',N'HH03',70.00000,344450.00000,24111500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 906,N'527CA923',N'8208E851',N'TP03',28.00000,1014615.00000,28409220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 907,N'527CA923',N'A75219AD',N'TP03',87.00000,929688.00000,80882856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 908,N'527CA923',N'5ABB4F1A',N'DIESEL',14.00000,724332.00000,10140648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 909,N'CDDCC841',N'126F83E4',N'NVL03',58.00000,327164.00000,18975512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 910,N'CDDCC841',N'94FD4757',N'TP03',22.00000,1042568.00000,22936496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 911,N'CDDCC841',N'14D03CA5',N'TP03',34.00000,512421.00000,17422314.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 912,N'CDDCC841',N'DB0C2CB7',N'A92',75.00000,807150.00000,60536250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 913,N'379C4DC8',N'E4F30AF7',N'TP02',45.00000,276560.00000,12445200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 914,N'379C4DC8',N'2A733690',N'NVL01',45.00000,565543.00000,25449435.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 915,N'379C4DC8',N'B94E5807',N'NVL03',69.00000,754248.00000,52043112.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 916,N'379C4DC8',N'39348F32',N'A95',63.00000,354998.00000,22364874.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 917,N'379C4DC8',N'A3A9C51F',N'TP03',73.00000,214906.00000,15688138.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 918,N'6A8183E8',N'9C3CAE9A',N'HH03',85.00000,800929.00000,68078965.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 919,N'6A8183E8',N'8DEE6B5F',N'A95',48.00000,654427.00000,31412496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 920,N'6A8183E8',N'63D2EBA1',N'A92',8.00000,870535.00000,6964280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 921,N'6A8183E8',N'018D0B19',N'NVL02',7.00000,921804.00000,6452628.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 922,N'09A1D33F',N'9A788C68',N'NVL02',41.00000,970231.00000,39779471.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 923,N'09A1D33F',N'4DF5C3AF',N'DIESEL',78.00000,450167.00000,35113026.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 924,N'09A1D33F',N'58ABC9EB',N'HH03',26.00000,118753.00000,3087578.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 925,N'09A1D33F',N'680A7051',N'NVL01',27.00000,793731.00000,21430737.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 926,N'09A1D33F',N'3F57BA99',N'TP02',23.00000,977439.00000,22481097.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 927,N'FCAC7A18',N'24A6CBAA',N'A95',88.00000,556364.00000,48960032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 928,N'FCAC7A18',N'162FEBCC',N'NVL02',49.00000,954172.00000,46754428.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 929,N'FCAC7A18',N'1E1F8B01',N'NVL03',42.00000,324393.00000,13624506.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 930,N'FCAC7A18',N'237718ED',N'A92',96.00000,190708.00000,18307968.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 931,N'FCAC7A18',N'AABB5159',N'HH01',79.00000,1039486.00000,82119394.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 932,N'FCAC7A18',N'6A16B125',N'HH02',71.00000,983041.00000,69795911.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 933,N'4F855035',N'C57C7603',N'NVL02',8.00000,263957.00000,2111656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 934,N'4F855035',N'86ABA3AD',N'TP02',17.00000,378927.00000,6441759.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 935,N'AEFF7119',N'227C9A25',N'TP02',77.00000,670568.00000,51633736.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 936,N'AEFF7119',N'ADF77799',N'TP01',88.00000,1031165.00000,90742520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 937,N'AEFF7119',N'150326F8',N'DIESEL',12.00000,547655.00000,6571860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 938,N'AEFF7119',N'E709FFF7',N'HH03',84.00000,1052574.00000,88416216.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 939,N'AEFF7119',N'C2D0D44F',N'TP02',86.00000,445163.00000,38284018.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 940,N'CC411A3A',N'995976EE',N'A92',71.00000,310187.00000,22023277.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 941,N'CC411A3A',N'2DD5863E',N'NVL02',17.00000,785166.00000,13347822.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 942,N'CC411A3A',N'84CEB2A2',N'TP02',55.00000,315782.00000,17368010.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 943,N'CC411A3A',N'D850720E',N'NVL02',85.00000,324263.00000,27562355.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 944,N'CC411A3A',N'B64C0933',N'TP01',22.00000,1032199.00000,22708378.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 945,N'72D1D64C',N'F655E097',N'NVL01',27.00000,997635.00000,26936145.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 946,N'72D1D64C',N'642A0303',N'A95',83.00000,774218.00000,64260094.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 947,N'72D1D64C',N'E0210108',N'A95',78.00000,774823.00000,60436194.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 948,N'72D1D64C',N'CABE18D3',N'TP03',55.00000,227689.00000,12522895.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 949,N'72D1D64C',N'FA6B9FF3',N'NVL02',50.00000,481931.00000,24096550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 950,N'AB0C6BA8',N'71AE5404',N'HH02',72.00000,201847.00000,14532984.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 951,N'AB0C6BA8',N'8C8A9E15',N'TP02',84.00000,301693.00000,25342212.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 952,N'AB0C6BA8',N'33F208BD',N'A92',98.00000,584360.00000,57267280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 953,N'AB0C6BA8',N'01343C0B',N'A92',4.00000,897869.00000,3591476.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 954,N'AB0C6BA8',N'E2A285B8',N'HH03',11.00000,278011.00000,3058121.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 955,N'DF2575F9',N'4E449CED',N'NVL02',55.00000,327207.00000,17996385.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 956,N'DF2575F9',N'96E258FC',N'NVL01',74.00000,114670.00000,8485580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 957,N'DF2575F9',N'C4577E40',N'NVL01',15.00000,428024.00000,6420360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 958,N'DF2575F9',N'6CE915CE',N'DIESEL',27.00000,283678.00000,7659306.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 959,N'DF2575F9',N'00CC2A05',N'A95',46.00000,377767.00000,17377282.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 960,N'DF2575F9',N'A2AF12A9',N'HH01',80.00000,956615.00000,76529200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 961,N'7256B33E',N'D8D84DED',N'TP02',64.00000,646616.00000,41383424.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 962,N'7256B33E',N'7345D292',N'NVL02',44.00000,808568.00000,35576992.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 963,N'BB3EDDBB',N'4F96DA26',N'NVL02',76.00000,509554.00000,38726104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 964,N'BB3EDDBB',N'4E4DB380',N'NVL01',96.00000,417288.00000,40059648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 965,N'05959C1E',N'53A352B9',N'TP03',85.00000,478916.00000,40707860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 966,N'05959C1E',N'89F3AD11',N'NVL01',66.00000,1040234.00000,68655444.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 967,N'05959C1E',N'7C5993ED',N'HH01',99.00000,546809.00000,54134091.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 968,N'05959C1E',N'9590117E',N'A92',75.00000,745453.00000,55908975.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 969,N'8C3234EA',N'BDDC47AD',N'HH01',94.00000,829145.00000,77939630.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 970,N'8C3234EA',N'C5F21204',N'NVL01',87.00000,236560.00000,20580720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 971,N'64CAA859',N'272B0CD4',N'A92',61.00000,335589.00000,20470929.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 972,N'64CAA859',N'3313ABF7',N'NVL01',66.00000,952324.00000,62853384.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 973,N'5E042D9E',N'F9F5C38C',N'TP02',39.00000,180439.00000,7037121.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 974,N'5E042D9E',N'DF5F2E27',N'TP02',97.00000,852548.00000,82697156.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 975,N'026FABE4',N'C9D232C1',N'HH01',45.00000,1006991.00000,45314595.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 976,N'026FABE4',N'9EE8FD1C',N'NVL03',90.00000,405055.00000,36454950.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 977,N'026FABE4',N'6EC4BDDB',N'HH03',68.00000,223964.00000,15229552.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 978,N'026FABE4',N'77C6974D',N'NVL01',88.00000,401334.00000,35317392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 979,N'026FABE4',N'DB1A0897',N'TP01',51.00000,843652.00000,43026252.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 980,N'B799F0ED',N'E7D5BD62',N'HH02',40.00000,302916.00000,12116640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 981,N'B799F0ED',N'91C33199',N'TP02',45.00000,1050059.00000,47252655.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 982,N'B799F0ED',N'06A67C5A',N'TP01',37.00000,322345.00000,11926765.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 983,N'B799F0ED',N'41C06CA8',N'NVL02',23.00000,260503.00000,5991569.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 984,N'B799F0ED',N'C537625F',N'TP01',31.00000,176789.00000,5480459.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 985,N'B799F0ED',N'573E135B',N'HH02',69.00000,698998.00000,48230862.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 986,N'262E7B8E',N'3D1C863D',N'TP01',19.00000,329374.00000,6258106.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 987,N'262E7B8E',N'11151D38',N'TP03',74.00000,210599.00000,15584326.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 988,N'262E7B8E',N'3329B2B0',N'TP01',97.00000,905946.00000,87876762.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 989,N'78F6DCC9',N'0B8E562D',N'NVL01',43.00000,947866.00000,40758238.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 990,N'78F6DCC9',N'E9AEEE1D',N'NVL02',8.00000,739526.00000,5916208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 991,N'78F6DCC9',N'387F7926',N'A92',99.00000,341775.00000,33835725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 992,N'F2D99F8D',N'ADC6DDAF',N'HH01',13.00000,1038699.00000,13503087.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 993,N'F2D99F8D',N'F0824069',N'NVL01',10.00000,108265.00000,1082650.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 994,N'F2D99F8D',N'780C4ED5',N'A95',14.00000,175921.00000,2462894.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 995,N'1BBA6CFA',N'368901D1',N'NVL01',81.00000,1042833.00000,84469473.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 996,N'1BBA6CFA',N'AD95C254',N'TP02',25.00000,454465.00000,11361625.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 997,N'1BBA6CFA',N'1E2CE97F',N'A92',7.00000,809065.00000,5663455.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 998,N'1BBA6CFA',N'A6FE931F',N'TP02',4.00000,337203.00000,1348812.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 999,N'1BBA6CFA',N'B72EC3EB',N'TP03',22.00000,369172.00000,8121784.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1000,N'1BBA6CFA',N'239E0337',N'TP03',7.00000,637843.00000,4464901.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1001,N'318FAD9A',N'196604EC',N'NVL01',71.00000,148456.00000,10540376.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1002,N'318FAD9A',N'397B9458',N'A92',89.00000,198582.00000,17673798.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1003,N'318FAD9A',N'45EDF7A4',N'NVL02',69.00000,344959.00000,23802171.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1004,N'318FAD9A',N'11DD54C6',N'NVL01',57.00000,262736.00000,14975952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1005,N'318FAD9A',N'67478B6B',N'NVL03',67.00000,279079.00000,18698293.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1006,N'0C14B4F2',N'25254C09',N'TP01',96.00000,837413.00000,80391648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1007,N'0C14B4F2',N'4EB9F9DF',N'NVL03',43.00000,1004764.00000,43204852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1008,N'0C14B4F2',N'5DF64E11',N'HH02',10.00000,457938.00000,4579380.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1009,N'0C14B4F2',N'D3598E9F',N'HH03',32.00000,319012.00000,10208384.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1010,N'EF8ED622',N'39D6E619',N'TP03',53.00000,470809.00000,24952877.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1011,N'EF8ED622',N'9B342A7A',N'A92',18.00000,782907.00000,14092326.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1012,N'1E550CD9',N'04806EE6',N'TP03',99.00000,654744.00000,64819656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1013,N'1E550CD9',N'BD84386E',N'HH01',26.00000,655670.00000,17047420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1014,N'A4140A77',N'D4720E02',N'TP03',86.00000,853434.00000,73395324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1015,N'A4140A77',N'6A1DF9E7',N'NVL02',18.00000,1062056.00000,19117008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1016,N'A4140A77',N'109DC9A9',N'NVL01',84.00000,534163.00000,44869692.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1017,N'A4140A77',N'8F31F3CC',N'DIESEL',87.00000,944585.00000,82178895.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1018,N'A4140A77',N'1C088A4C',N'TP02',52.00000,795088.00000,41344576.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1019,N'A4140A77',N'EAFFA485',N'HH02',93.00000,865000.00000,80445000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1020,N'E465170D',N'D61CAC30',N'TP03',45.00000,794676.00000,35760420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1021,N'E465170D',N'914CA1B4',N'A95',38.00000,801855.00000,30470490.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1022,N'E465170D',N'83D58639',N'TP01',30.00000,753384.00000,22601520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1023,N'E465170D',N'3C076D9B',N'A92',84.00000,981553.00000,82450452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1024,N'E465170D',N'870CA10F',N'A92',59.00000,520212.00000,30692508.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1025,N'14993665',N'AC9D334D',N'NVL01',36.00000,815553.00000,29359908.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1026,N'14993665',N'D6E88BD5',N'NVL02',17.00000,628823.00000,10689991.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1027,N'14993665',N'C6129228',N'TP03',17.00000,787480.00000,13387160.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1028,N'14993665',N'F49C0135',N'NVL03',63.00000,111955.00000,7053165.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1029,N'14993665',N'854A4F55',N'HH01',5.00000,984754.00000,4923770.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1030,N'2875B9C5',N'3B10AD53',N'NVL01',40.00000,874883.00000,34995320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1031,N'2875B9C5',N'E9BCA6CD',N'TP01',58.00000,867848.00000,50335184.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1032,N'2875B9C5',N'09248631',N'TP02',53.00000,511178.00000,27092434.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1033,N'2875B9C5',N'5F2E4A9F',N'HH02',90.00000,102061.00000,9185490.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1034,N'2875B9C5',N'B2508E2A',N'NVL02',21.00000,671750.00000,14106750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1035,N'78DC7C18',N'0D5AFFAF',N'TP01',71.00000,114240.00000,8111040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1036,N'78DC7C18',N'9CAEDDE6',N'HH02',63.00000,281862.00000,17757306.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1037,N'78DC7C18',N'2771F546',N'TP03',61.00000,417824.00000,25487264.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1038,N'82D901F8',N'DC1937A0',N'HH02',34.00000,726359.00000,24696206.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1039,N'B94F7966',N'C23C34BC',N'HH01',8.00000,823263.00000,6586104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1040,N'B94F7966',N'2796D9DC',N'HH01',56.00000,513527.00000,28757512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1041,N'B94F7966',N'23B5DB3B',N'A92',52.00000,981757.00000,51051364.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1042,N'D4D8EF4D',N'9A4BA8B8',N'TP01',78.00000,466246.00000,36367188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1043,N'E93398E2',N'9625CDCF',N'TP02',4.00000,155177.00000,620708.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1044,N'E93398E2',N'972DA6B8',N'A92',79.00000,460228.00000,36358012.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1045,N'E93398E2',N'6A00F08D',N'NVL01',52.00000,925642.00000,48133384.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1046,N'E93398E2',N'22A47E0D',N'NVL03',7.00000,364836.00000,2553852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1047,N'21923A01',N'410BFF77',N'A95',42.00000,303778.00000,12758676.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1048,N'10AF8CCF',N'08918449',N'NVL01',4.00000,246909.00000,987636.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1049,N'103F82D7',N'1129B238',N'A92',83.00000,147269.00000,12223327.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1050,N'D2264DB7',N'9762BF01',N'HH01',22.00000,585028.00000,12870616.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1051,N'D2264DB7',N'292C8C68',N'TP01',71.00000,178488.00000,12672648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1052,N'D2264DB7',N'F3F41C26',N'A92',57.00000,865180.00000,49315260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1053,N'D2264DB7',N'1F584E2C',N'A95',86.00000,678654.00000,58364244.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1054,N'2AAD2CB0',N'FEBC6229',N'NVL02',38.00000,1035367.00000,39343946.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1055,N'2AAD2CB0',N'4FAF87EB',N'TP01',86.00000,147037.00000,12645182.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1056,N'2AAD2CB0',N'82575868',N'TP03',96.00000,973451.00000,93451296.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1057,N'20A3A387',N'7A77AFBF',N'A95',22.00000,808286.00000,17782292.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1058,N'20A3A387',N'CD6B2157',N'NVL01',95.00000,174823.00000,16608185.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1059,N'20A3A387',N'7CEDCADC',N'NVL02',82.00000,805108.00000,66018856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1060,N'20A3A387',N'4102A0CE',N'HH03',45.00000,1055394.00000,47492730.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1061,N'5549A90E',N'27CC5B30',N'HH03',26.00000,844501.00000,21957026.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1062,N'5549A90E',N'0BFDCF3E',N'A95',54.00000,729540.00000,39395160.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1063,N'5549A90E',N'FBE5EEA7',N'DIESEL',72.00000,134165.00000,9659880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1064,N'94D30B96',N'54A6923B',N'TP01',78.00000,655120.00000,51099360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1065,N'94D30B96',N'B7CAB5C1',N'TP02',27.00000,809842.00000,21865734.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1066,N'D4067527',N'EC88A1E9',N'NVL02',49.00000,686911.00000,33658639.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1067,N'D4067527',N'13CF60E4',N'TP01',18.00000,682613.00000,12287034.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1068,N'C6D2DCAD',N'2650A672',N'A95',24.00000,916295.00000,21991080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1069,N'C6D2DCAD',N'0AD6A021',N'DIESEL',59.00000,554077.00000,32690543.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1070,N'C6D2DCAD',N'EEA7630A',N'TP01',51.00000,129084.00000,6583284.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1071,N'C6D2DCAD',N'CAD1CD09',N'NVL01',86.00000,766602.00000,65927772.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1072,N'C6D2DCAD',N'6C528E63',N'TP02',7.00000,1085840.00000,7600880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1073,N'0496300B',N'A876081D',N'DIESEL',30.00000,568962.00000,17068860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1074,N'0496300B',N'E31A59C8',N'HH01',32.00000,958521.00000,30672672.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1075,N'0496300B',N'CA1B3EA0',N'NVL03',9.00000,421280.00000,3791520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1076,N'0496300B',N'BBA9EFA8',N'TP01',93.00000,502908.00000,46770444.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1077,N'0496300B',N'85EDEEAF',N'TP03',5.00000,925739.00000,4628695.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1078,N'474C70FF',N'16DFB844',N'A92',96.00000,518762.00000,49801152.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1079,N'474C70FF',N'0D99404C',N'HH02',70.00000,475163.00000,33261410.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1080,N'474C70FF',N'5EF6CCC8',N'NVL01',4.00000,447053.00000,1788212.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1081,N'474C70FF',N'7BEA6397',N'A92',75.00000,673820.00000,50536500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1082,N'78237FE7',N'40B3C361',N'TP01',39.00000,261741.00000,10207899.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1083,N'78237FE7',N'39F4590E',N'TP01',100.00000,412328.00000,41232800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1084,N'5005E90C',N'778F8F0E',N'NVL02',3.00000,374426.00000,1123278.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1085,N'5005E90C',N'C51B1A8B',N'HH03',72.00000,1010784.00000,72776448.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1086,N'5005E90C',N'CB72F117',N'TP01',61.00000,265516.00000,16196476.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1087,N'2847E9DC',N'B2AADCEB',N'TP02',75.00000,1012233.00000,75917475.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1088,N'2847E9DC',N'2455CC16',N'HH01',35.00000,933188.00000,32661580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1089,N'2847E9DC',N'B5360803',N'HH03',91.00000,274605.00000,24989055.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1090,N'2847E9DC',N'201E4B20',N'NVL01',44.00000,659922.00000,29036568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1091,N'2847E9DC',N'1CD8D9FE',N'A92',92.00000,804379.00000,74002868.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1092,N'2847E9DC',N'DCF9D7AF',N'HH02',5.00000,162717.00000,813585.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1093,N'DDCFB3EA',N'EEBD3179',N'TP02',67.00000,521517.00000,34941639.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1094,N'2CCC3285',N'92CFA4D8',N'NVL01',9.00000,532358.00000,4791222.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1095,N'2CCC3285',N'DA4EBC33',N'A95',69.00000,811156.00000,55969764.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1096,N'2CCC3285',N'FAD9884C',N'HH03',32.00000,178896.00000,5724672.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1097,N'2CCC3285',N'92CA0564',N'A95',63.00000,626175.00000,39449025.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1098,N'2CCC3285',N'315A3377',N'TP03',79.00000,346557.00000,27378003.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1099,N'DD1440DF',N'D4662A55',N'DIESEL',74.00000,153033.00000,11324442.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1100,N'B0A518C5',N'E770BC9F',N'A95',18.00000,449842.00000,8097156.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1101,N'B0A518C5',N'BF65B1BF',N'TP02',56.00000,827935.00000,46364360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1102,N'3887CB6C',N'6E3AF992',N'HH01',101.00000,292155.00000,29507655.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1103,N'3887CB6C',N'A7D3EE94',N'HH02',36.00000,187118.00000,6736248.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1104,N'3887CB6C',N'DD37F6FB',N'TP02',35.00000,786556.00000,27529460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1105,N'3887CB6C',N'3641AE4A',N'TP03',23.00000,1088587.00000,25037501.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1106,N'24A19B17',N'062E1179',N'HH01',78.00000,182578.00000,14241084.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1107,N'24A19B17',N'26AFD59B',N'A92',80.00000,830663.00000,66453040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1108,N'24A19B17',N'284642A6',N'TP01',61.00000,1099070.00000,67043270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1109,N'24A19B17',N'52757800',N'DIESEL',83.00000,432936.00000,35933688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1110,N'0328FB5F',N'3BEAE50D',N'NVL03',56.00000,776543.00000,43486408.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1111,N'0328FB5F',N'502E3E4A',N'A95',85.00000,133218.00000,11323530.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1112,N'0328FB5F',N'61ACBE61',N'HH02',40.00000,284863.00000,11394520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1113,N'0328FB5F',N'075AABF1',N'HH01',93.00000,864825.00000,80428725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1114,N'BB1783C8',N'2491D185',N'HH02',71.00000,487351.00000,34601921.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1115,N'BB1783C8',N'5335DCC8',N'NVL02',36.00000,254339.00000,9156204.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1116,N'BB1783C8',N'432AB72B',N'TP02',90.00000,174940.00000,15744600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1117,N'BB1783C8',N'01F81313',N'TP03',41.00000,428067.00000,17550747.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1118,N'BB1783C8',N'B94F3AC3',N'TP01',82.00000,234569.00000,19234658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1119,N'92C0503F',N'C84FD7CE',N'HH03',78.00000,849793.00000,66283854.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1120,N'972357A0',N'E2763925',N'NVL01',30.00000,872191.00000,26165730.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1121,N'972357A0',N'F89EED76',N'NVL02',41.00000,1001768.00000,41072488.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1122,N'972357A0',N'6914948A',N'NVL02',57.00000,1051727.00000,59948439.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1123,N'972357A0',N'8DFAD77D',N'TP01',20.00000,709119.00000,14182380.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1124,N'49950CB3',N'06F641FB',N'NVL03',18.00000,707926.00000,12742668.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1125,N'49950CB3',N'ED329597',N'NVL01',59.00000,278131.00000,16409729.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1126,N'49950CB3',N'BEBC305D',N'NVL02',90.00000,246262.00000,22163580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1127,N'49950CB3',N'CCDB087D',N'TP02',84.00000,885378.00000,74371752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1128,N'FC16E96B',N'D731C9A8',N'DIESEL',80.00000,635922.00000,50873760.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1129,N'FC16E96B',N'3A82ACCD',N'NVL01',23.00000,694723.00000,15978629.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1130,N'FC16E96B',N'DA873559',N'A92',21.00000,660016.00000,13860336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1131,N'22ABB33C',N'4B050644',N'TP03',70.00000,904737.00000,63331590.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1132,N'22ABB33C',N'C0C0F200',N'HH01',79.00000,879833.00000,69506807.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1133,N'22ABB33C',N'B8E01665',N'HH02',65.00000,1087288.00000,70673720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1134,N'22ABB33C',N'CE0DF62B',N'A95',49.00000,969773.00000,47518877.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1135,N'1D4ED283',N'8337744B',N'HH03',25.00000,175912.00000,4397800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1136,N'1D4ED283',N'CBBF44DF',N'HH02',30.00000,887765.00000,26632950.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1137,N'1D4ED283',N'418BDBC7',N'HH02',76.00000,1006240.00000,76474240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1138,N'1D4ED283',N'D8B7CB6F',N'NVL02',74.00000,825034.00000,61052516.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1139,N'8A16CD78',N'5B956D6A',N'NVL02',50.00000,227850.00000,11392500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1140,N'8A16CD78',N'4657954B',N'HH03',71.00000,206435.00000,14656885.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1141,N'8A16CD78',N'F4555F4B',N'DIESEL',14.00000,587699.00000,8227786.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1142,N'8A16CD78',N'6ED265C5',N'TP03',3.00000,936479.00000,2809437.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1143,N'8A16CD78',N'8F70A77F',N'HH01',9.00000,518238.00000,4664142.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1144,N'436FD3A6',N'F11C1424',N'TP03',22.00000,1017407.00000,22382954.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1145,N'436FD3A6',N'FE749E8D',N'HH03',33.00000,853810.00000,28175730.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1146,N'310A71B4',N'AE859ECD',N'A95',87.00000,887081.00000,77176047.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1147,N'310A71B4',N'551B8086',N'NVL01',97.00000,706535.00000,68533895.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1148,N'310A71B4',N'150DEA95',N'TP01',91.00000,606703.00000,55209973.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1149,N'E1FDCC39',N'952B5668',N'HH03',32.00000,213813.00000,6842016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1150,N'E1FDCC39',N'8FA73D9F',N'TP03',3.00000,1099001.00000,3297003.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1151,N'AF781BB6',N'38F17023',N'TP02',66.00000,447599.00000,29541534.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1152,N'DD037203',N'A2FCF079',N'HH01',15.00000,200795.00000,3011925.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1153,N'DD037203',N'563D1B65',N'TP03',75.00000,868143.00000,65110725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1154,N'DD037203',N'5B96A5E3',N'NVL01',14.00000,598295.00000,8376130.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1155,N'DD037203',N'FC1E2BC1',N'TP01',75.00000,703515.00000,52763625.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1156,N'DD037203',N'48A0FF3F',N'A95',51.00000,248962.00000,12697062.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1157,N'B5D2172B',N'3C81863F',N'HH03',96.00000,327198.00000,31411008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1158,N'54E5FFA7',N'5FA8652C',N'NVL02',92.00000,295509.00000,27186828.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1159,N'54E5FFA7',N'0C306820',N'DIESEL',3.00000,595708.00000,1787124.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1160,N'54E5FFA7',N'2D1FA467',N'TP01',3.00000,650579.00000,1951737.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1161,N'54E5FFA7',N'EC9293CF',N'TP02',18.00000,210474.00000,3788532.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1162,N'F5D27578',N'84842DE8',N'A92',49.00000,351160.00000,17206840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1163,N'F5D27578',N'17441547',N'DIESEL',8.00000,684044.00000,5472352.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1164,N'F5D27578',N'B8922C05',N'TP03',37.00000,100671.00000,3724827.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1165,N'F5D27578',N'837FE64A',N'A92',86.00000,1027720.00000,88383920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1166,N'813C4D2E',N'3C1B33DE',N'TP02',92.00000,450873.00000,41480316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1167,N'813C4D2E',N'167040A5',N'NVL01',62.00000,987808.00000,61244096.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1168,N'4F3B5E86',N'4BA997A2',N'HH03',38.00000,1087121.00000,41310598.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1169,N'4F3B5E86',N'CE5DE262',N'A92',81.00000,785309.00000,63610029.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1170,N'4F3B5E86',N'3234999B',N'TP03',89.00000,722338.00000,64288082.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1171,N'4F3B5E86',N'76C5FF02',N'NVL02',37.00000,928867.00000,34368079.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1172,N'0A881F10',N'DDAFC8D4',N'TP01',100.00000,127553.00000,12755300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1173,N'0A881F10',N'5AE156C3',N'A95',64.00000,247094.00000,15814016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1174,N'0A881F10',N'BC9074D2',N'TP03',99.00000,248782.00000,24629418.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1175,N'0A881F10',N'2F5688FB',N'HH03',29.00000,972680.00000,28207720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1176,N'CABC0F2B',N'30CC9FDF',N'NVL02',79.00000,650716.00000,51406564.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1177,N'CABC0F2B',N'01104E77',N'DIESEL',68.00000,773346.00000,52587528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1178,N'CABC0F2B',N'9F7656E5',N'A92',31.00000,180508.00000,5595748.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1179,N'CABC0F2B',N'7DE58170',N'DIESEL',12.00000,926652.00000,11119824.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1180,N'CABC0F2B',N'B5434B3C',N'HH01',30.00000,730444.00000,21913320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1181,N'CABC0F2B',N'F10FCC4C',N'HH02',80.00000,357017.00000,28561360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1182,N'048F58E7',N'5F8AC02F',N'A95',81.00000,251342.00000,20358702.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1183,N'048F58E7',N'294C2F08',N'TP02',49.00000,138210.00000,6772290.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1184,N'048F58E7',N'53761CB6',N'DIESEL',74.00000,324467.00000,24010558.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1185,N'048F58E7',N'BB02B78E',N'DIESEL',49.00000,860225.00000,42151025.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1186,N'048F58E7',N'381E1B28',N'HH03',83.00000,1070915.00000,88885945.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1187,N'17704497',N'1CC94EE0',N'A95',17.00000,165741.00000,2817597.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1188,N'17704497',N'B3B3E87B',N'HH01',71.00000,151050.00000,10724550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1189,N'17704497',N'22274480',N'NVL01',92.00000,703360.00000,64709120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1190,N'17704497',N'A7AE3D4F',N'HH02',52.00000,1039536.00000,54055872.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1191,N'17704497',N'99C30C64',N'TP02',5.00000,729927.00000,3649635.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1192,N'AE457D5D',N'E53F106B',N'NVL02',43.00000,408698.00000,17574014.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1193,N'AE457D5D',N'6D44A398',N'A92',95.00000,831913.00000,79031735.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1194,N'AE457D5D',N'C64389EC',N'NVL01',70.00000,124426.00000,8709820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1195,N'AE457D5D',N'D0CB3ABB',N'TP01',41.00000,1011339.00000,41464899.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1196,N'AE457D5D',N'E9C918CE',N'HH01',64.00000,435837.00000,27893568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1197,N'AE457D5D',N'B806DB08',N'NVL02',80.00000,926420.00000,74113600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1198,N'41BF25FD',N'1BCF1E04',N'A92',65.00000,861401.00000,55991065.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1199,N'41BF25FD',N'B265777D',N'NVL03',58.00000,865393.00000,50192794.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1200,N'41BF25FD',N'F0AD3D8E',N'NVL03',68.00000,316665.00000,21533220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1201,N'41BF25FD',N'3E2184E1',N'A92',44.00000,384468.00000,16916592.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1202,N'41BF25FD',N'701084DB',N'TP01',55.00000,999676.00000,54982180.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1203,N'36904EAE',N'6E7561C5',N'NVL03',42.00000,931881.00000,39139002.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1204,N'36904EAE',N'8C50C98E',N'HH01',100.00000,780644.00000,78064400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1205,N'36904EAE',N'0D72414D',N'A95',50.00000,520706.00000,26035300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1206,N'36904EAE',N'20F14B85',N'HH02',11.00000,934720.00000,10281920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1207,N'500A026F',N'95FD858A',N'NVL02',99.00000,628106.00000,62182494.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1208,N'500A026F',N'2B56D3C5',N'NVL03',44.00000,413050.00000,18174200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1209,N'500A026F',N'D0F27957',N'DIESEL',48.00000,538759.00000,25860432.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1210,N'500A026F',N'FDED6767',N'A92',88.00000,750153.00000,66013464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1211,N'500A026F',N'E654237E',N'NVL01',99.00000,1006733.00000,99666567.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1212,N'500A026F',N'3AE3A692',N'DIESEL',12.00000,652943.00000,7835316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1213,N'2C19F331',N'F721EEC5',N'TP02',1.00000,792653.00000,792653.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1214,N'2C19F331',N'F0BAA180',N'A92',95.00000,328381.00000,31196195.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1215,N'2C19F331',N'9F6A578E',N'A92',83.00000,1000624.00000,83051792.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1216,N'2C19F331',N'318836AA',N'HH03',82.00000,388597.00000,31864954.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1217,N'2C19F331',N'EF9D276B',N'DIESEL',3.00000,764650.00000,2293950.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1218,N'267BC7B3',N'4D57ADAF',N'NVL03',62.00000,937400.00000,58118800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1219,N'267BC7B3',N'F648B3C3',N'TP02',59.00000,570189.00000,33641151.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1220,N'BBC7F04B',N'005ADF78',N'A95',28.00000,684130.00000,19155640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1221,N'BBC7F04B',N'4BB4A767',N'DIESEL',74.00000,848942.00000,62821708.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1222,N'BBC7F04B',N'8AFD56E5',N'DIESEL',24.00000,994619.00000,23870856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1223,N'BBC7F04B',N'7FD715BD',N'DIESEL',53.00000,319455.00000,16931115.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1224,N'BBC7F04B',N'0999EEA4',N'A95',4.00000,1007866.00000,4031464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1225,N'174EFBC6',N'BE157379',N'A92',9.00000,526872.00000,4741848.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1226,N'174EFBC6',N'91A54831',N'TP02',20.00000,862805.00000,17256100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1227,N'174EFBC6',N'71285F13',N'TP03',57.00000,618162.00000,35235234.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1228,N'65F968A5',N'FC6F2259',N'HH03',12.00000,675595.00000,8107140.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1229,N'65F968A5',N'39CDDCE5',N'NVL02',45.00000,633039.00000,28486755.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1230,N'65F968A5',N'FC5D5F52',N'HH02',4.00000,110158.00000,440632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1231,N'6835CAFB',N'C752834A',N'DIESEL',30.00000,215517.00000,6465510.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1232,N'6835CAFB',N'10D9B350',N'TP03',93.00000,729014.00000,67798302.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1233,N'6835CAFB',N'A4D1FB4A',N'TP01',55.00000,867183.00000,47695065.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1234,N'6835CAFB',N'66E5E4D5',N'TP01',55.00000,629786.00000,34638230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1235,N'6835CAFB',N'DC26434F',N'HH02',82.00000,708267.00000,58077894.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1236,N'FB618DA7',N'B5B8E39A',N'TP01',38.00000,525624.00000,19973712.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1237,N'FB618DA7',N'0B98319E',N'HH03',13.00000,373356.00000,4853628.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1238,N'6AEA4A3D',N'691B1612',N'TP01',85.00000,527451.00000,44833335.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1239,N'6AEA4A3D',N'4B7DD23D',N'NVL02',1.00000,245860.00000,245860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1240,N'FD57FE27',N'B4FB0678',N'NVL01',81.00000,167258.00000,13547898.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1241,N'FD57FE27',N'5033AF95',N'NVL03',84.00000,331010.00000,27804840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1242,N'FD57FE27',N'4F56E2DC',N'TP03',67.00000,183334.00000,12283378.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1243,N'FD57FE27',N'83FE12F6',N'DIESEL',45.00000,496035.00000,22321575.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1244,N'312F87D2',N'6B1EF915',N'HH01',66.00000,620582.00000,40958412.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1245,N'312F87D2',N'686B5B2C',N'HH02',99.00000,181645.00000,17982855.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1246,N'312F87D2',N'8C8D0510',N'NVL02',57.00000,581669.00000,33155133.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1247,N'312F87D2',N'D3E504A8',N'A95',73.00000,834506.00000,60918938.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1248,N'312F87D2',N'4C5C5DC2',N'NVL02',96.00000,778247.00000,74711712.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1249,N'312F87D2',N'C36B6CD5',N'NVL01',2.00000,590822.00000,1181644.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1250,N'FF485FF8',N'D818C61B',N'HH01',70.00000,1070058.00000,74904060.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1251,N'FF485FF8',N'976150C0',N'TP03',92.00000,473584.00000,43569728.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1252,N'FF485FF8',N'F76CCFF8',N'HH03',18.00000,850372.00000,15306696.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1253,N'98560EA6',N'2D79B5E7',N'A95',18.00000,678118.00000,12206124.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1254,N'98560EA6',N'EA97A95A',N'TP03',95.00000,205105.00000,19484975.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1255,N'98560EA6',N'A09E9D5F',N'HH03',2.00000,844126.00000,1688252.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1256,N'98560EA6',N'122A79FE',N'A92',23.00000,990458.00000,22780534.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1257,N'625B0B26',N'EC9FB73E',N'A92',22.00000,1032681.00000,22718982.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1258,N'84B5BF4E',N'5843C27C',N'TP01',91.00000,1050746.00000,95617886.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1259,N'AE400C27',N'1CF4CA4F',N'DIESEL',100.00000,363570.00000,36357000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1260,N'AE400C27',N'7FCC76B7',N'A92',54.00000,199360.00000,10765440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1261,N'AE400C27',N'6D647C2E',N'A92',50.00000,413677.00000,20683850.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1262,N'AE400C27',N'FA9640D5',N'HH02',21.00000,1067040.00000,22407840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1263,N'01DADE7A',N'33A1A524',N'A95',2.00000,860744.00000,1721488.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1264,N'01DADE7A',N'7CA3A763',N'TP01',52.00000,1050084.00000,54604368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1265,N'01DADE7A',N'5DE01D01',N'NVL02',71.00000,397846.00000,28247066.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1266,N'01DADE7A',N'BE4B7DAD',N'A92',54.00000,140160.00000,7568640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1267,N'587A14AE',N'133B160C',N'TP01',5.00000,958450.00000,4792250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1268,N'587A14AE',N'7BB937AE',N'A92',25.00000,517598.00000,12939950.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1269,N'3DD4EB09',N'804506EC',N'DIESEL',74.00000,562934.00000,41657116.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1270,N'3DD4EB09',N'DB17C3CA',N'TP03',100.00000,911033.00000,91103300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1271,N'3DD4EB09',N'69EC26F1',N'DIESEL',42.00000,707383.00000,29710086.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1272,N'3DD4EB09',N'174354D3',N'TP03',50.00000,453806.00000,22690300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1273,N'3DD4EB09',N'59F2026C',N'TP02',11.00000,717268.00000,7889948.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1274,N'B742019A',N'0EAACB44',N'HH03',67.00000,579528.00000,38828376.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1275,N'B0E17DA1',N'39D9E05D',N'TP01',80.00000,263911.00000,21112880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1276,N'E088C3F9',N'5C701399',N'HH01',21.00000,477698.00000,10031658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1277,N'E088C3F9',N'67BCBA0E',N'HH02',10.00000,387482.00000,3874820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1278,N'E088C3F9',N'3DB88696',N'NVL03',10.00000,140054.00000,1400540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1279,N'9AEA27B5',N'E6A21E72',N'DIESEL',69.00000,1018941.00000,70306929.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1280,N'9AEA27B5',N'F15EF3D6',N'A95',30.00000,1000211.00000,30006330.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1281,N'9AEA27B5',N'7A07F0F6',N'NVL03',65.00000,561893.00000,36523045.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1282,N'9AEA27B5',N'B65D6F3C',N'TP02',90.00000,638167.00000,57435030.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1283,N'9AEA27B5',N'173F286C',N'A92',64.00000,133209.00000,8525376.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1284,N'BE77DCE9',N'C3BE99B8',N'NVL02',47.00000,376273.00000,17684831.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1285,N'BE77DCE9',N'543E02EF',N'NVL02',65.00000,159902.00000,10393630.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1286,N'FF8537FA',N'32EEE61C',N'NVL03',67.00000,385402.00000,25821934.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1287,N'FF8537FA',N'A5E67E68',N'NVL01',57.00000,555994.00000,31691658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1288,N'FF8537FA',N'1800A12B',N'NVL02',17.00000,638036.00000,10846612.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1289,N'ACAD83FE',N'821BEDB7',N'TP03',22.00000,819017.00000,18018374.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1290,N'730DA1DD',N'28477BF8',N'TP02',58.00000,641003.00000,37178174.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1291,N'730DA1DD',N'002F953A',N'NVL03',55.00000,286593.00000,15762615.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1292,N'730DA1DD',N'B84723E9',N'NVL03',89.00000,157291.00000,13998899.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1293,N'730DA1DD',N'C80C9F9B',N'HH02',4.00000,605118.00000,2420472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1294,N'730DA1DD',N'F22FC793',N'NVL01',99.00000,840923.00000,83251377.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1295,N'730DA1DD',N'D5BB1351',N'HH02',28.00000,697641.00000,19533948.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1296,N'94407E71',N'468CFC61',N'HH01',29.00000,396603.00000,11501487.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1297,N'D8754151',N'854B4762',N'TP01',25.00000,317891.00000,7947275.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1298,N'D8754151',N'D02C5C13',N'A92',93.00000,315591.00000,29349963.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1299,N'D8754151',N'BD2D69C4',N'HH02',49.00000,990846.00000,48551454.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1300,N'D8754151',N'EBE61AEB',N'DIESEL',98.00000,909567.00000,89137566.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1301,N'D8754151',N'15DEBBCC',N'NVL01',10.00000,995454.00000,9954540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1302,N'D8754151',N'F9FE3B9A',N'TP02',73.00000,594882.00000,43426386.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1303,N'C40A5C1E',N'95540F8A',N'DIESEL',68.00000,1078427.00000,73333036.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1304,N'C40A5C1E',N'7B385EA5',N'NVL03',60.00000,591405.00000,35484300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1305,N'C40A5C1E',N'7325EBF4',N'NVL02',60.00000,776704.00000,46602240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1306,N'C40A5C1E',N'F77ED90D',N'HH01',17.00000,554725.00000,9430325.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1307,N'C40A5C1E',N'340A6EAA',N'HH02',19.00000,225502.00000,4284538.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1308,N'70CBE1E7',N'0A664BD1',N'TP02',36.00000,1072129.00000,38596644.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1309,N'70CBE1E7',N'248CEF71',N'NVL02',16.00000,1036941.00000,16591056.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1310,N'70CBE1E7',N'3FE82B1A',N'HH01',82.00000,794922.00000,65183604.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1311,N'70CBE1E7',N'B3219314',N'TP02',11.00000,417672.00000,4594392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1312,N'70CBE1E7',N'543F7332',N'NVL03',93.00000,960719.00000,89346867.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1313,N'70CBE1E7',N'B1440ADF',N'A92',73.00000,524415.00000,38282295.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1314,N'F3AF5448',N'401DD3F5',N'NVL01',28.00000,506421.00000,14179788.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1315,N'F3AF5448',N'245C9349',N'NVL01',98.00000,686923.00000,67318454.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1316,N'F3AF5448',N'E5DC508E',N'TP01',53.00000,548498.00000,29070394.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1317,N'F3AF5448',N'62593811',N'HH02',88.00000,892661.00000,78554168.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1318,N'FE21A21B',N'89AE459E',N'TP03',75.00000,104773.00000,7857975.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1319,N'FE21A21B',N'C9AE53E9',N'NVL01',9.00000,656389.00000,5907501.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1320,N'FE21A21B',N'50DBACA4',N'HH01',88.00000,353294.00000,31089872.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1321,N'FE21A21B',N'C094AB20',N'HH03',80.00000,165913.00000,13273040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1322,N'FE21A21B',N'34D80D83',N'HH03',22.00000,985303.00000,21676666.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1323,N'FE21A21B',N'F5EEACCF',N'HH03',76.00000,184063.00000,13988788.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1324,N'F4180BEB',N'78EBE208',N'NVL02',23.00000,797441.00000,18341143.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1325,N'F4180BEB',N'82F59CFF',N'TP01',63.00000,294313.00000,18541719.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1326,N'02A4393B',N'22589E1B',N'HH02',8.00000,604797.00000,4838376.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1327,N'02A4393B',N'4DAE3C4A',N'HH03',45.00000,743036.00000,33436620.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1328,N'02A4393B',N'AB4B5CF7',N'DIESEL',39.00000,386586.00000,15076854.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1329,N'68E857B2',N'54840DB2',N'HH01',53.00000,717078.00000,38005134.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1330,N'68E857B2',N'0F4709A3',N'HH01',53.00000,293257.00000,15542621.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1331,N'68E857B2',N'5B21FAD8',N'HH01',39.00000,489448.00000,19088472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1332,N'68E857B2',N'DDD3C4D9',N'DIESEL',52.00000,167882.00000,8729864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1333,N'68E857B2',N'77C45DE6',N'HH01',32.00000,297950.00000,9534400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1334,N'68E857B2',N'E26A3C4C',N'TP03',31.00000,756264.00000,23444184.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1335,N'44B2CE84',N'2C616C53',N'HH02',64.00000,359352.00000,22998528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1336,N'44B2CE84',N'0E5BBAF7',N'DIESEL',24.00000,345531.00000,8292744.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1337,N'44B2CE84',N'3D00A705',N'NVL03',29.00000,836945.00000,24271405.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1338,N'44B2CE84',N'7838F6A7',N'TP02',6.00000,1070357.00000,6422142.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1339,N'A4741CDB',N'2E0C33D7',N'NVL01',73.00000,861457.00000,62886361.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1340,N'A4741CDB',N'5FF029B3',N'HH01',25.00000,517375.00000,12934375.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1341,N'A4741CDB',N'449945BA',N'NVL03',63.00000,541807.00000,34133841.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1342,N'A4741CDB',N'7085C3E4',N'HH01',80.00000,767977.00000,61438160.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1343,N'A4741CDB',N'4BF2A195',N'TP01',68.00000,104451.00000,7102668.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1344,N'A4741CDB',N'FB8736F2',N'HH03',48.00000,817085.00000,39220080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1345,N'A320B7B3',N'4F7E68F8',N'DIESEL',46.00000,397400.00000,18280400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1346,N'A320B7B3',N'6CA735D8',N'A95',9.00000,615295.00000,5537655.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1347,N'C505BFF9',N'50568FAE',N'A95',99.00000,442505.00000,43807995.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1348,N'C505BFF9',N'E27E514A',N'NVL02',83.00000,455376.00000,37796208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1349,N'C505BFF9',N'F0D38C59',N'TP03',68.00000,331601.00000,22548868.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1350,N'C505BFF9',N'BBA49810',N'TP03',64.00000,516243.00000,33039552.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1351,N'C505BFF9',N'70D69641',N'DIESEL',38.00000,895569.00000,34031622.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1352,N'E00AF193',N'36541846',N'DIESEL',34.00000,982728.00000,33412752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1353,N'E00AF193',N'6295C383',N'TP03',34.00000,1061331.00000,36085254.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1354,N'E00AF193',N'E0A6E6C2',N'NVL01',16.00000,1018590.00000,16297440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1355,N'E00AF193',N'889D5073',N'NVL01',29.00000,158830.00000,4606070.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1356,N'B287CE1D',N'ECE01921',N'A95',6.00000,1024306.00000,6145836.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1357,N'B287CE1D',N'65A6CFFD',N'HH02',84.00000,395170.00000,33194280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1358,N'F4372DF9',N'81B90436',N'TP03',95.00000,557597.00000,52971715.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1359,N'F4372DF9',N'85A13F79',N'HH01',27.00000,981368.00000,26496936.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1360,N'F4372DF9',N'4E0184A6',N'HH01',25.00000,1048633.00000,26215825.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1361,N'F4372DF9',N'16D8D637',N'HH02',84.00000,509511.00000,42798924.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1362,N'E78CDBF3',N'141F0CB9',N'NVL02',99.00000,726667.00000,71940033.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1363,N'E78CDBF3',N'09B6E10B',N'HH03',53.00000,976971.00000,51779463.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1364,N'E78CDBF3',N'03013684',N'NVL02',66.00000,294069.00000,19408554.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1365,N'E78CDBF3',N'18BBDF08',N'TP03',45.00000,1062034.00000,47791530.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1366,N'90B2164C',N'A076A9CA',N'TP02',3.00000,417537.00000,1252611.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1367,N'90B2164C',N'941BCF71',N'NVL03',17.00000,908171.00000,15438907.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1368,N'90B2164C',N'400A40B6',N'NVL03',23.00000,1091887.00000,25113401.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1369,N'90B2164C',N'D66BC219',N'TP03',71.00000,708528.00000,50305488.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1370,N'E45FD338',N'B1AC2569',N'NVL01',9.00000,308621.00000,2777589.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1371,N'E45FD338',N'57908BAB',N'DIESEL',12.00000,444657.00000,5335884.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1372,N'E45FD338',N'B91BC981',N'NVL02',33.00000,280049.00000,9241617.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1373,N'C61BE242',N'48E2C9E0',N'NVL02',79.00000,751286.00000,59351594.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1374,N'C61BE242',N'B38A9703',N'A95',58.00000,1094451.00000,63478158.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1375,N'C61BE242',N'31EB0D78',N'A92',100.00000,683850.00000,68385000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1376,N'C61BE242',N'842B2799',N'TP01',27.00000,350160.00000,9454320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1377,N'C61BE242',N'D2FDBE7F',N'TP02',90.00000,792210.00000,71298900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1378,N'C61BE242',N'D90CFEB7',N'NVL01',16.00000,1058212.00000,16931392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1379,N'58F97E37',N'61580AED',N'NVL03',43.00000,1037189.00000,44599127.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1380,N'58F97E37',N'63E9EF2F',N'HH03',60.00000,288670.00000,17320200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1381,N'58F97E37',N'D8E16079',N'TP01',101.00000,367724.00000,37140124.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1382,N'9919390A',N'1271165F',N'HH02',86.00000,542446.00000,46650356.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1383,N'9919390A',N'B3E772E5',N'A92',94.00000,602531.00000,56637914.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1384,N'9919390A',N'417DF282',N'A95',51.00000,422332.00000,21538932.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1385,N'D25FBD3B',N'60C2E5D7',N'NVL03',6.00000,249776.00000,1498656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1386,N'D25FBD3B',N'7C96C09F',N'NVL02',71.00000,724301.00000,51425371.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1387,N'1E4BDEF6',N'BA51E0CF',N'HH01',4.00000,297916.00000,1191664.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1388,N'1E4BDEF6',N'75318AB4',N'A92',23.00000,847115.00000,19483645.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1389,N'1E4BDEF6',N'7892C995',N'HH01',41.00000,954740.00000,39144340.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1390,N'1E4BDEF6',N'5877B816',N'A95',39.00000,509030.00000,19852170.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1391,N'69C524E0',N'5A7DAAF8',N'A92',56.00000,363871.00000,20376776.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1392,N'69C524E0',N'12F21826',N'HH02',36.00000,1070414.00000,38534904.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1393,N'69C524E0',N'6800FF3F',N'HH02',81.00000,642256.00000,52022736.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1394,N'69C524E0',N'C5F6A885',N'DIESEL',9.00000,233424.00000,2100816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1395,N'C5A068BD',N'C2D32068',N'A95',69.00000,623030.00000,42989070.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1396,N'C5A068BD',N'D209C3A0',N'TP01',39.00000,1030467.00000,40188213.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1397,N'924990E7',N'0DEED8ED',N'A95',47.00000,210321.00000,9885087.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1398,N'924990E7',N'077244B2',N'HH03',26.00000,543689.00000,14135914.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1399,N'924990E7',N'05ECFA99',N'NVL03',62.00000,390186.00000,24191532.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1400,N'924990E7',N'4883B76A',N'TP02',59.00000,436370.00000,25745830.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1401,N'6B3A8E70',N'FB9B08CB',N'TP02',98.00000,709997.00000,69579706.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1402,N'6B3A8E70',N'CE5B3608',N'TP03',18.00000,588931.00000,10600758.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1403,N'6B3A8E70',N'349F51E5',N'NVL01',14.00000,1010442.00000,14146188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1404,N'6B3A8E70',N'C3BD4A65',N'DIESEL',93.00000,831464.00000,77326152.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1405,N'6B3A8E70',N'B0003675',N'A92',41.00000,747020.00000,30627820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1406,N'928A00CC',N'7FA6F678',N'A95',96.00000,681405.00000,65414880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1407,N'960CFA22',N'49CAA4A0',N'NVL01',40.00000,573774.00000,22950960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1408,N'960CFA22',N'6DCEB2D8',N'HH01',10.00000,1048088.00000,10480880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1409,N'960CFA22',N'E52BE600',N'A95',38.00000,211706.00000,8044828.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1410,N'960CFA22',N'8F502585',N'TP03',22.00000,823900.00000,18125800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1411,N'960CFA22',N'F4719FAF',N'DIESEL',93.00000,996055.00000,92633115.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1412,N'960CFA22',N'2BD747AA',N'HH01',48.00000,751159.00000,36055632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1413,N'5BA8E165',N'BB661171',N'A95',88.00000,763044.00000,67147872.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1414,N'5BA8E165',N'99E211E2',N'HH02',55.00000,209510.00000,11523050.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1415,N'5BA8E165',N'E011442D',N'A92',24.00000,519585.00000,12470040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1416,N'290CBC58',N'EC6B9409',N'DIESEL',3.00000,1050170.00000,3150510.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1417,N'290CBC58',N'5DB71628',N'TP01',68.00000,427205.00000,29049940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1418,N'290CBC58',N'2ACEF1FC',N'HH01',13.00000,825191.00000,10727483.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1419,N'290CBC58',N'F284D1DF',N'TP02',55.00000,442376.00000,24330680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1420,N'290CBC58',N'CAE0B481',N'TP01',68.00000,916900.00000,62349200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1421,N'290CBC58',N'B0033CB8',N'HH03',6.00000,810701.00000,4864206.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1422,N'1DF53F35',N'CF310CF5',N'TP01',33.00000,101218.00000,3340194.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1423,N'1DF53F35',N'ECA18533',N'TP03',30.00000,501991.00000,15059730.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1424,N'1DF53F35',N'D6A4BCEA',N'TP03',20.00000,849194.00000,16983880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1425,N'89C903E8',N'2CBE5A56',N'TP02',43.00000,444836.00000,19127948.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1426,N'89C903E8',N'2867418E',N'HH02',84.00000,441671.00000,37100364.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1427,N'89C903E8',N'70D77F54',N'TP03',91.00000,924806.00000,84157346.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1428,N'04EC4938',N'55E4A928',N'DIESEL',4.00000,216131.00000,864524.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1429,N'04EC4938',N'7F357FC9',N'TP02',87.00000,293221.00000,25510227.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1430,N'04EC4938',N'41E6F95E',N'NVL03',31.00000,995747.00000,30868157.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1431,N'04EC4938',N'229D9B93',N'HH01',46.00000,590620.00000,27168520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1432,N'04EC4938',N'D5EB347C',N'TP02',15.00000,277765.00000,4166475.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1433,N'04EC4938',N'F97C8F3D',N'NVL02',83.00000,726148.00000,60270284.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1434,N'B8B1E67D',N'4DA8236B',N'NVL02',75.00000,753858.00000,56539350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1435,N'B8B1E67D',N'F0AD0448',N'TP03',87.00000,834604.00000,72610548.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1436,N'B8B1E67D',N'AC85EBB7',N'NVL03',75.00000,577072.00000,43280400.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1437,N'B8B1E67D',N'AC8A0497',N'DIESEL',55.00000,376897.00000,20729335.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1438,N'B8B1E67D',N'E77C2509',N'TP01',51.00000,660687.00000,33695037.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1439,N'B8B1E67D',N'8D734A35',N'TP01',35.00000,410347.00000,14362145.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1440,N'52AA2219',N'4C54C0E4',N'HH02',19.00000,332867.00000,6324473.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1441,N'52AA2219',N'27CF1077',N'NVL02',27.00000,577007.00000,15579189.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1442,N'52AA2219',N'724D10F5',N'TP01',98.00000,457984.00000,44882432.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1443,N'52AA2219',N'CF0F17AA',N'NVL01',15.00000,571985.00000,8579775.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1444,N'52AA2219',N'E454C05B',N'A92',61.00000,684267.00000,41740287.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1445,N'55678CDB',N'751BA4EB',N'HH03',57.00000,407393.00000,23221401.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1446,N'F3E8F691',N'C028D673',N'HH01',38.00000,734746.00000,27920348.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1447,N'F3E8F691',N'AD54C74F',N'NVL01',99.00000,956716.00000,94714884.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1448,N'E57611DF',N'179BB6C4',N'DIESEL',84.00000,930001.00000,78120084.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1449,N'E57611DF',N'5AE50D2A',N'NVL01',79.00000,558887.00000,44152073.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1450,N'E57611DF',N'F9E9BE16',N'A92',1.00000,969689.00000,969689.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1451,N'E57611DF',N'85FB5319',N'HH02',86.00000,456366.00000,39247476.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1452,N'E57611DF',N'69762FD0',N'NVL02',90.00000,951410.00000,85626900.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1453,N'C673E31C',N'A708C8B1',N'NVL02',85.00000,869917.00000,73942945.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1454,N'C673E31C',N'B5B60798',N'HH02',36.00000,334225.00000,12032100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1455,N'C673E31C',N'A58FC95F',N'A95',60.00000,918949.00000,55136940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1456,N'C673E31C',N'B2D7F921',N'DIESEL',5.00000,324849.00000,1624245.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1457,N'57FB715B',N'35FBD567',N'HH03',20.00000,863809.00000,17276180.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1458,N'57FB715B',N'AB9301AE',N'HH02',16.00000,880837.00000,14093392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1459,N'57FB715B',N'3FB256B1',N'NVL01',2.00000,679906.00000,1359812.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1460,N'57FB715B',N'BC70876E',N'TP01',45.00000,550173.00000,24757785.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1461,N'8FE2C366',N'FEB7839D',N'A92',78.00000,356276.00000,27789528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1462,N'8FE2C366',N'02B46748',N'HH01',60.00000,436809.00000,26208540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1463,N'8FE2C366',N'B05B209A',N'TP01',65.00000,853103.00000,55451695.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1464,N'8FE2C366',N'03945C92',N'HH03',11.00000,647972.00000,7127692.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1465,N'8FE2C366',N'9E1E4958',N'TP02',2.00000,488440.00000,976880.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1466,N'2060889B',N'311D23C9',N'TP01',31.00000,357741.00000,11089971.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1467,N'2060889B',N'8512A43B',N'A95',73.00000,473580.00000,34571340.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1468,N'2060889B',N'29A0121A',N'DIESEL',49.00000,294550.00000,14432950.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1469,N'2060889B',N'71F46264',N'TP02',2.00000,1065995.00000,2131990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1470,N'461213F6',N'9B4C941B',N'NVL03',50.00000,979615.00000,48980750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1471,N'461213F6',N'B043208E',N'DIESEL',56.00000,514550.00000,28814800.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1472,N'461213F6',N'67CB6FC8',N'TP03',96.00000,672756.00000,64584576.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1473,N'461213F6',N'B1CDC51D',N'DIESEL',35.00000,375183.00000,13131405.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1474,N'461213F6',N'3936E15F',N'HH03',17.00000,923008.00000,15691136.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1475,N'461213F6',N'2AF27DF5',N'A95',4.00000,492184.00000,1968736.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1476,N'F844ED57',N'C22228A6',N'HH03',6.00000,329375.00000,1976250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1477,N'F844ED57',N'73F855C7',N'HH02',66.00000,1048261.00000,69185226.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1478,N'F844ED57',N'A18DBA48',N'NVL03',16.00000,816532.00000,13064512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1479,N'F844ED57',N'06FBC2C1',N'A95',60.00000,332113.00000,19926780.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1480,N'F844ED57',N'7B513FDF',N'A92',40.00000,496516.00000,19860640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1481,N'720C843F',N'4F513131',N'HH01',11.00000,539790.00000,5937690.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1482,N'720C843F',N'89AB562F',N'TP01',91.00000,866608.00000,78861328.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1483,N'C2ED007A',N'B39431B1',N'A95',26.00000,936742.00000,24355292.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1484,N'C2ED007A',N'B3A5FE1A',N'TP02',97.00000,625091.00000,60633827.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1485,N'C2ED007A',N'1E02F1D0',N'TP01',27.00000,1033868.00000,27914436.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1486,N'C2ED007A',N'8A0B7F45',N'TP03',97.00000,756951.00000,73424247.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1487,N'C2ED007A',N'B386615D',N'A95',28.00000,445579.00000,12476212.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1488,N'84E78C18',N'806B9BC1',N'TP03',23.00000,142896.00000,3286608.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1489,N'84E78C18',N'D6C02C88',N'DIESEL',37.00000,450147.00000,16655439.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1490,N'84E78C18',N'44EA5F11',N'DIESEL',33.00000,282749.00000,9330717.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1491,N'5E7A4AC3',N'CDD933AA',N'A95',58.00000,949314.00000,55060212.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1492,N'5E7A4AC3',N'CDE7868B',N'NVL03',34.00000,1036880.00000,35253920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1493,N'5E7A4AC3',N'0F740954',N'TP02',34.00000,426690.00000,14507460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1494,N'30F26FF6',N'BECACC66',N'TP03',15.00000,792678.00000,11890170.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1495,N'30F26FF6',N'E0967118',N'HH03',43.00000,794434.00000,34160662.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1496,N'A0398152',N'7CC4ED74',N'NVL01',23.00000,275686.00000,6340778.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1497,N'2A0D5B3A',N'2F3B81D2',N'TP02',35.00000,856717.00000,29985095.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1498,N'2A0D5B3A',N'AEF3298D',N'TP02',40.00000,681087.00000,27243480.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1499,N'2A0D5B3A',N'1590FF06',N'NVL03',67.00000,632242.00000,42360214.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1500,N'2A0D5B3A',N'88485602',N'TP03',13.00000,545422.00000,7090486.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1501,N'EC6358D9',N'BD85776F',N'TP01',82.00000,883083.00000,72412806.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1502,N'EC6358D9',N'C2CC37F4',N'TP01',52.00000,488677.00000,25411204.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1503,N'EC6358D9',N'903F3329',N'TP03',4.00000,647116.00000,2588464.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1504,N'944A4245',N'BA8E7338',N'TP01',79.00000,956800.00000,75587200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1505,N'944A4245',N'2988E2A3',N'HH01',47.00000,685994.00000,32241718.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1506,N'944A4245',N'A460A37A',N'HH01',39.00000,119244.00000,4650516.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1507,N'944A4245',N'CC73472F',N'HH01',85.00000,330903.00000,28126755.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1508,N'66DFD3CE',N'592D6272',N'DIESEL',57.00000,807551.00000,46030407.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1509,N'270FF4AF',N'3B38FB26',N'A92',43.00000,817691.00000,35160713.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1510,N'270FF4AF',N'F8D6E520',N'TP02',40.00000,468989.00000,18759560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1511,N'270FF4AF',N'0CC98142',N'HH01',55.00000,327235.00000,17997925.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1512,N'270FF4AF',N'0B47056C',N'TP03',89.00000,297290.00000,26458810.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1513,N'270FF4AF',N'6420EC30',N'NVL02',59.00000,286917.00000,16928103.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1514,N'3C6252BE',N'1EC7C724',N'TP01',57.00000,881982.00000,50272974.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1515,N'3C6252BE',N'97AE0622',N'TP03',38.00000,825943.00000,31385834.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1516,N'3C6252BE',N'34CE3B65',N'HH02',88.00000,1016976.00000,89493888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1517,N'3C6252BE',N'DBB6AA20',N'TP01',20.00000,751710.00000,15034200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1518,N'3C6252BE',N'536F09E5',N'HH01',79.00000,644478.00000,50913762.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1519,N'3C6252BE',N'6AC13A72',N'HH02',68.00000,865880.00000,58879840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1520,N'86844527',N'AC062E63',N'A95',11.00000,560770.00000,6168470.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1521,N'86844527',N'71575BB9',N'HH03',37.00000,746177.00000,27608549.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1522,N'86844527',N'32ED01D9',N'TP02',30.00000,1059789.00000,31793670.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1523,N'86844527',N'8454E6CD',N'NVL02',8.00000,522411.00000,4179288.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1524,N'86844527',N'9C19C06A',N'HH02',64.00000,449122.00000,28743808.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1525,N'86844527',N'B233E213',N'NVL03',35.00000,136709.00000,4784815.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1526,N'AD8C8E3E',N'907CCF7B',N'TP03',55.00000,583079.00000,32069345.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1527,N'AD8C8E3E',N'91E55F08',N'HH02',57.00000,1066858.00000,60810906.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1528,N'AD8C8E3E',N'ACA2372B',N'NVL03',73.00000,863588.00000,63041924.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1529,N'AD8C8E3E',N'3F886C9A',N'NVL03',59.00000,846111.00000,49920549.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1530,N'AD8C8E3E',N'E6423DAB',N'A95',92.00000,948290.00000,87242680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1531,N'77FDE0BC',N'F7659C7E',N'NVL01',6.00000,794189.00000,4765134.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1532,N'77FDE0BC',N'04F2C208',N'HH02',6.00000,302927.00000,1817562.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1533,N'77FDE0BC',N'17F16E73',N'A92',58.00000,681709.00000,39539122.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1534,N'77FDE0BC',N'789EC3C3',N'TP03',50.00000,175404.00000,8770200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1535,N'7458086F',N'1E202612',N'A95',15.00000,862244.00000,12933660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1536,N'7458086F',N'959D2527',N'NVL03',52.00000,755574.00000,39289848.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1537,N'7458086F',N'F4756681',N'A92',47.00000,244554.00000,11494038.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1538,N'3F6E8C7D',N'023CEA3D',N'TP01',17.00000,740550.00000,12589350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1539,N'8165C432',N'A1835639',N'TP03',54.00000,318138.00000,17179452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1540,N'8165C432',N'D2634799',N'HH01',10.00000,814594.00000,8145940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1541,N'8165C432',N'29C0CC33',N'TP03',4.00000,785842.00000,3143368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1542,N'8165C432',N'4930DB4C',N'TP02',70.00000,485361.00000,33975270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1543,N'8165C432',N'08DDA023',N'A92',86.00000,362171.00000,31146706.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1544,N'8165C432',N'A0C3F181',N'HH02',75.00000,874190.00000,65564250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1545,N'F18125E5',N'E474BD0F',N'TP02',70.00000,925461.00000,64782270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1546,N'F18125E5',N'67585F0B',N'DIESEL',30.00000,580879.00000,17426370.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1547,N'F18125E5',N'D4A0FBC1',N'NVL03',73.00000,1073598.00000,78372654.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1548,N'E2A1E21F',N'5E58F4D7',N'HH03',75.00000,207387.00000,15554025.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1549,N'545D04C0',N'E818FF22',N'HH02',33.00000,235472.00000,7770576.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1550,N'CB145B3B',N'59C63F18',N'TP03',19.00000,380809.00000,7235371.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1551,N'7DDB4ACF',N'8C0AB70D',N'TP03',8.00000,1099523.00000,8796184.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1552,N'7DDB4ACF',N'3C52C521',N'NVL03',19.00000,959130.00000,18223470.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1553,N'C78A995A',N'7DD1F833',N'A95',47.00000,716410.00000,33671270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1554,N'E7CC2D53',N'B350C292',N'NVL01',57.00000,336845.00000,19200165.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1555,N'E7CC2D53',N'BCFB80A5',N'HH03',52.00000,597196.00000,31054192.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1556,N'E7CC2D53',N'F7074997',N'A92',98.00000,1019844.00000,99944712.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1557,N'CB994B26',N'F732D822',N'NVL02',16.00000,853152.00000,13650432.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1558,N'CB994B26',N'6EFFC6A0',N'NVL01',59.00000,601593.00000,35493987.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1559,N'CB994B26',N'63DC54A1',N'NVL02',15.00000,152915.00000,2293725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1560,N'CB994B26',N'7BF117F7',N'NVL01',91.00000,163475.00000,14876225.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1561,N'CB994B26',N'11675B85',N'TP03',68.00000,205105.00000,13947140.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1562,N'A0656E2E',N'15013D7F',N'A95',65.00000,208471.00000,13550615.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1563,N'C1E3B1EE',N'30FF2D76',N'HH01',25.00000,147635.00000,3690875.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1564,N'C1E3B1EE',N'07F1C1E9',N'NVL02',86.00000,529810.00000,45563660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1565,N'C1E3B1EE',N'98C642BE',N'NVL01',2.00000,1027067.00000,2054134.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1566,N'C1E3B1EE',N'B688A266',N'NVL03',78.00000,600733.00000,46857174.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1567,N'C1E3B1EE',N'494E5600',N'NVL03',24.00000,609933.00000,14638392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1568,N'46587167',N'5378A6EF',N'HH03',21.00000,587392.00000,12335232.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1569,N'46587167',N'88B8D5B5',N'HH01',32.00000,495203.00000,15846496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1570,N'46587167',N'96D22930',N'HH01',24.00000,731727.00000,17561448.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1571,N'46587167',N'2F7B5A28',N'NVL02',37.00000,356696.00000,13197752.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1572,N'46587167',N'62A2A309',N'NVL02',27.00000,105360.00000,2844720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1573,N'46587167',N'B80B28DA',N'TP03',23.00000,131818.00000,3031814.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1574,N'434D1798',N'115D084A',N'HH01',93.00000,1060860.00000,98659980.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1575,N'434D1798',N'137B4E3D',N'DIESEL',59.00000,159121.00000,9388139.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1576,N'434D1798',N'2AC2D7A9',N'NVL03',83.00000,687641.00000,57074203.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1577,N'434D1798',N'236DE8DE',N'HH01',66.00000,587689.00000,38787474.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1578,N'434D1798',N'6C836195',N'NVL01',79.00000,163946.00000,12951734.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1579,N'412F0AD3',N'DCD27EA7',N'NVL03',26.00000,549416.00000,14284816.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1580,N'412F0AD3',N'0D776291',N'HH01',52.00000,785811.00000,40862172.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1581,N'412F0AD3',N'82F514CD',N'HH02',83.00000,955244.00000,79285252.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1582,N'412F0AD3',N'5A3A375F',N'HH01',2.00000,234938.00000,469876.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1583,N'412F0AD3',N'7FBAB2E5',N'NVL03',35.00000,933332.00000,32666620.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1584,N'AD80B60C',N'06DBB56C',N'A95',24.00000,939307.00000,22543368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1585,N'AD80B60C',N'DD4E7B3C',N'NVL01',25.00000,606261.00000,15156525.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1586,N'AD80B60C',N'D883622F',N'NVL02',94.00000,948949.00000,89201206.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1587,N'C81F7F24',N'8504437E',N'TP03',59.00000,468277.00000,27628343.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1588,N'C81F7F24',N'7AC0D99B',N'A92',25.00000,761229.00000,19030725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1589,N'C81F7F24',N'EC82EF10',N'TP01',60.00000,268335.00000,16100100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1590,N'C81F7F24',N'4A781367',N'TP01',94.00000,273639.00000,25722066.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1591,N'75926FE5',N'6A8BA026',N'TP03',98.00000,163943.00000,16066414.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1592,N'75926FE5',N'51F44B32',N'TP02',14.00000,489812.00000,6857368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1593,N'75926FE5',N'2D950905',N'HH02',70.00000,243061.00000,17014270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1594,N'75926FE5',N'19224CF4',N'NVL03',38.00000,1092753.00000,41524614.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1595,N'B9B65C70',N'C3DE35B6',N'DIESEL',3.00000,855399.00000,2566197.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1596,N'B9B65C70',N'6CF6515E',N'A92',19.00000,262336.00000,4984384.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1597,N'B9B65C70',N'2F08566D',N'A92',21.00000,1046614.00000,21978894.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1598,N'B9B65C70',N'07BD1F39',N'DIESEL',6.00000,285777.00000,1714662.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1599,N'91951BA0',N'103095E5',N'A95',12.00000,870576.00000,10446912.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1600,N'91951BA0',N'688F1DEB',N'A92',71.00000,358534.00000,25455914.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1601,N'183BDEA9',N'0D98D617',N'TP01',23.00000,865921.00000,19916183.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1602,N'183BDEA9',N'56D5D886',N'TP03',98.00000,763145.00000,74788210.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1603,N'183BDEA9',N'48465727',N'DIESEL',97.00000,581954.00000,56449538.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1604,N'183BDEA9',N'AF9A83D7',N'A95',83.00000,1016192.00000,84343936.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1605,N'21B4B980',N'5DCC6473',N'HH01',100.00000,376332.00000,37633200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1606,N'21B4B980',N'B8DB9748',N'DIESEL',49.00000,285476.00000,13988324.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1607,N'21B4B980',N'8A4F81B5',N'HH02',22.00000,761993.00000,16763846.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1608,N'75AB513F',N'F92F4B40',N'NVL01',40.00000,1068246.00000,42729840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1609,N'1F8070AA',N'DDF38CAE',N'TP02',72.00000,396060.00000,28516320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1610,N'1F8070AA',N'AFFE3899',N'HH01',44.00000,321190.00000,14132360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1611,N'1F8070AA',N'6FD5792A',N'HH03',66.00000,417160.00000,27532560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1612,N'D73CEE49',N'7E9C8966',N'NVL01',26.00000,293346.00000,7626996.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1613,N'D73CEE49',N'459B45D1',N'NVL02',54.00000,720650.00000,38915100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1614,N'D73CEE49',N'7C905B66',N'NVL03',81.00000,537171.00000,43510851.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1615,N'D73CEE49',N'DFC065DC',N'NVL01',6.00000,851972.00000,5111832.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1616,N'D73CEE49',N'6531769B',N'TP03',68.00000,472748.00000,32146864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1617,N'2C28B84B',N'1DCD74FF',N'TP02',66.00000,819062.00000,54058092.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1618,N'8725D3C3',N'7C22FA00',N'DIESEL',2.00000,572021.00000,1144042.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1619,N'8725D3C3',N'B59D95C7',N'TP02',1.00000,1071227.00000,1071227.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1620,N'8725D3C3',N'A7744DB1',N'TP02',91.00000,633085.00000,57610735.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1621,N'8725D3C3',N'9D8DC72F',N'HH01',41.00000,594763.00000,24385283.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1622,N'A88C8707',N'58EBC42B',N'DIESEL',52.00000,457993.00000,23815636.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1623,N'A88C8707',N'D8D1EDC0',N'A92',45.00000,274841.00000,12367845.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1624,N'A88C8707',N'F66E207A',N'NVL02',42.00000,269070.00000,11300940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1625,N'A88C8707',N'712836A5',N'HH02',48.00000,774706.00000,37185888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1626,N'A88C8707',N'5B043455',N'HH01',68.00000,1039029.00000,70653972.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1627,N'880A6B10',N'009D8A57',N'NVL01',64.00000,1092736.00000,69935104.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1628,N'880A6B10',N'9C621910',N'TP01',49.00000,835663.00000,40947487.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1629,N'F54D7120',N'5D9BEE6F',N'NVL02',6.00000,986386.00000,5918316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1630,N'F54D7120',N'9322D84A',N'HH01',91.00000,195526.00000,17792866.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1631,N'F54D7120',N'B6A4F1C6',N'A92',52.00000,385228.00000,20031856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1632,N'F54D7120',N'9F5307A9',N'HH02',83.00000,900120.00000,74709960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1633,N'F54D7120',N'D4ED0467',N'NVL01',70.00000,859753.00000,60182710.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1634,N'90641A82',N'37218B62',N'TP02',89.00000,873386.00000,77731354.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1635,N'E24CDFB0',N'10AF62A8',N'HH02',89.00000,858958.00000,76447262.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1636,N'E24CDFB0',N'9EB3B9A8',N'NVL03',19.00000,429117.00000,8153223.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1637,N'E24CDFB0',N'2EB5433E',N'HH02',19.00000,497059.00000,9444121.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1638,N'354EB548',N'87F57387',N'HH01',94.00000,361545.00000,33985230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1639,N'354EB548',N'6E13E1FD',N'NVL02',95.00000,750387.00000,71286765.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1640,N'354EB548',N'F4355B12',N'A95',4.00000,562660.00000,2250640.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1641,N'354EB548',N'DFF8A197',N'HH01',88.00000,597636.00000,52591968.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1642,N'5A120B09',N'D72915EC',N'HH02',74.00000,293528.00000,21721072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1643,N'5A120B09',N'9C35F2C5',N'TP01',68.00000,320091.00000,21766188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1644,N'5A120B09',N'A4024325',N'A95',57.00000,764624.00000,43583568.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1645,N'5A120B09',N'0CD1B58A',N'HH03',5.00000,254892.00000,1274460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1646,N'B1613A59',N'5DA97037',N'HH03',3.00000,1043744.00000,3131232.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1647,N'B1613A59',N'B285A443',N'TP03',100.00000,139841.00000,13984100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1648,N'B1613A59',N'F5EE5CC9',N'NVL01',13.00000,112731.00000,1465503.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1649,N'B1613A59',N'4EE4219D',N'A95',98.00000,1085021.00000,106332058.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1650,N'1ED5DED5',N'925A2426',N'A92',82.00000,108999.00000,8937918.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1651,N'1ED5DED5',N'0F9D4AE7',N'NVL03',84.00000,1042182.00000,87543288.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1652,N'A1B45B9A',N'2FD70380',N'HH02',91.00000,451283.00000,41066753.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1653,N'A1B45B9A',N'039F399F',N'HH02',93.00000,713569.00000,66361917.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1654,N'A1B45B9A',N'BAB19818',N'NVL03',41.00000,110996.00000,4550836.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1655,N'62909350',N'383CD3B4',N'NVL03',91.00000,923797.00000,84065527.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1656,N'62909350',N'408EF57C',N'HH03',81.00000,406491.00000,32925771.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1657,N'62909350',N'55E3F386',N'TP03',13.00000,1050775.00000,13660075.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1658,N'62909350',N'D3EEF49C',N'HH02',96.00000,1046398.00000,100454208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1659,N'70A58019',N'400CCAC8',N'TP03',17.00000,488522.00000,8304874.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1660,N'70A58019',N'EB7A8BE5',N'NVL03',84.00000,588435.00000,49428540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1661,N'70A58019',N'D04D71AF',N'NVL02',3.00000,100246.00000,300738.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1662,N'70A58019',N'195A42B7',N'A95',2.00000,855184.00000,1710368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1663,N'70A58019',N'0E21C49B',N'TP02',43.00000,122479.00000,5266597.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1664,N'1C497312',N'4F6DD800',N'TP02',38.00000,211977.00000,8055126.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1665,N'1C497312',N'D4284794',N'HH02',4.00000,749003.00000,2996012.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1666,N'1C497312',N'0C192C94',N'TP02',56.00000,550939.00000,30852584.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1667,N'1C497312',N'4AF65033',N'TP01',2.00000,886852.00000,1773704.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1668,N'4EF9B025',N'7A57D80D',N'TP02',10.00000,511232.00000,5112320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1669,N'4EF9B025',N'6FFF5D12',N'TP03',62.00000,103484.00000,6416008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1670,N'4EF9B025',N'A32F15E5',N'DIESEL',58.00000,371970.00000,21574260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1671,N'4EF9B025',N'EF717B73',N'A95',76.00000,733546.00000,55749496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1672,N'4EF9B025',N'92F0137C',N'A92',33.00000,1028907.00000,33953931.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1673,N'9BFBBF4E',N'8F470B29',N'NVL03',24.00000,814109.00000,19538616.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1674,N'9BFBBF4E',N'A0AF3075',N'NVL01',33.00000,553655.00000,18270615.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1675,N'C4116F6A',N'FD580C93',N'HH03',84.00000,540282.00000,45383688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1676,N'C4116F6A',N'3DD54CA1',N'TP01',50.00000,933421.00000,46671050.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1677,N'C4116F6A',N'91267508',N'A95',59.00000,930509.00000,54900031.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1678,N'99015083',N'8C460924',N'A92',71.00000,248003.00000,17608213.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1679,N'99015083',N'85597B21',N'NVL03',55.00000,482317.00000,26527435.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1680,N'99015083',N'75C5A4EC',N'A92',44.00000,988765.00000,43505660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1681,N'CB445661',N'BBBA90CD',N'DIESEL',26.00000,778490.00000,20240740.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1682,N'CB445661',N'9ACE52F0',N'NVL03',91.00000,333701.00000,30366791.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1683,N'CB445661',N'2A702029',N'DIESEL',62.00000,453099.00000,28092138.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1684,N'CB445661',N'618B36BC',N'DIESEL',14.00000,646474.00000,9050636.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1685,N'CB445661',N'A5E45427',N'TP02',90.00000,813683.00000,73231470.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1686,N'E1A33163',N'9DE25C95',N'HH02',9.00000,408518.00000,3676662.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1687,N'E1A33163',N'B05F32F0',N'A95',72.00000,487070.00000,35069040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1688,N'E1A33163',N'BE666C3A',N'HH03',31.00000,846384.00000,26237904.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1689,N'E1A33163',N'DD4751FC',N'NVL02',1.00000,372403.00000,372403.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1690,N'E1A33163',N'5235EE64',N'HH01',61.00000,281342.00000,17161862.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1691,N'E1A33163',N'B7300FFB',N'TP03',36.00000,948832.00000,34157952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1692,N'32B0CD14',N'2ED4DC3C',N'TP03',59.00000,531071.00000,31333189.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1693,N'32B0CD14',N'C90FD8DD',N'A92',3.00000,1089319.00000,3267957.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1694,N'D4233A2A',N'38945FD6',N'HH01',100.00000,286586.00000,28658600.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1695,N'D4233A2A',N'9B740F6D',N'A92',40.00000,973456.00000,38938240.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1696,N'D4233A2A',N'9D62FA13',N'NVL02',53.00000,877716.00000,46518948.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1697,N'D4233A2A',N'21F170A9',N'A92',81.00000,901007.00000,72981567.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1698,N'3351CD8C',N'9870238F',N'NVL01',12.00000,697166.00000,8365992.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1699,N'3351CD8C',N'2090171F',N'NVL01',8.00000,500847.00000,4006776.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1700,N'3351CD8C',N'36B38856',N'NVL02',63.00000,174927.00000,11020401.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1701,N'3351CD8C',N'C0444E33',N'A92',25.00000,574446.00000,14361150.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1702,N'3351CD8C',N'6E589DDC',N'A95',46.00000,205392.00000,9448032.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1703,N'7C9ACB95',N'6D7737F1',N'TP03',42.00000,522599.00000,21949158.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1704,N'7C9ACB95',N'79A6FE8B',N'TP02',75.00000,926298.00000,69472350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1705,N'7C9ACB95',N'CA1D6857',N'NVL02',79.00000,851940.00000,67303260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1706,N'A1DC838D',N'D21BB2C2',N'TP03',91.00000,482571.00000,43913961.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1707,N'A1DC838D',N'CA216905',N'TP02',60.00000,643111.00000,38586660.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1708,N'A1DC838D',N'E6220587',N'TP03',99.00000,858306.00000,84972294.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1709,N'B3C297C2',N'8B06B2A2',N'HH01',53.00000,525830.00000,27868990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1710,N'314BC7C9',N'8F708CFB',N'TP02',32.00000,883095.00000,28259040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1711,N'314BC7C9',N'0B987F19',N'NVL02',63.00000,933629.00000,58818627.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1712,N'314BC7C9',N'8458CA2E',N'HH03',79.00000,1013303.00000,80050937.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1713,N'7B8D128C',N'CDAB4850',N'TP01',1.00000,660750.00000,660750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1714,N'7B8D128C',N'406C3C2F',N'DIESEL',67.00000,567659.00000,38033153.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1715,N'7B8D128C',N'43067B0B',N'NVL02',30.00000,1003489.00000,30104670.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1716,N'121BD240',N'D3576D60',N'DIESEL',26.00000,153378.00000,3987828.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1717,N'121BD240',N'4FED3B73',N'TP02',47.00000,144204.00000,6777588.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1718,N'71A496EB',N'EA614466',N'TP03',50.00000,608501.00000,30425050.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1719,N'71A496EB',N'C216790A',N'HH01',95.00000,481634.00000,45755230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1720,N'71A496EB',N'B4182AD5',N'NVL01',22.00000,149359.00000,3285898.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1721,N'71A496EB',N'09D09DF2',N'DIESEL',88.00000,577769.00000,50843672.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1722,N'71A496EB',N'0B054AB4',N'DIESEL',69.00000,823734.00000,56837646.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1723,N'71A496EB',N'A947429B',N'NVL01',56.00000,236179.00000,13226024.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1724,N'B7E92339',N'570806D3',N'A92',19.00000,1090130.00000,20712470.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1725,N'B7E92339',N'86E86FD7',N'NVL01',14.00000,137730.00000,1928220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1726,N'B7E92339',N'6B218F96',N'DIESEL',52.00000,291322.00000,15148744.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1727,N'50CB0AA1',N'2F7F3221',N'NVL03',21.00000,618224.00000,12982704.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1728,N'0CCBED96',N'1C58AF44',N'TP01',19.00000,613812.00000,11662428.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1729,N'0CCBED96',N'67F9F403',N'NVL01',20.00000,965419.00000,19308380.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1730,N'0CCBED96',N'2CE69237',N'NVL02',32.00000,490835.00000,15706720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1731,N'0CCBED96',N'1453BEA8',N'A95',82.00000,190760.00000,15642320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1732,N'0CCBED96',N'BF8C528D',N'HH03',43.00000,1024760.00000,44064680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1733,N'AE2CE7DA',N'0A6E633D',N'HH03',70.00000,583961.00000,40877270.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1734,N'AE2CE7DA',N'E3FBA136',N'A95',43.00000,402730.00000,17317390.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1735,N'AE2CE7DA',N'B7B39DD4',N'DIESEL',66.00000,470538.00000,31055508.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1736,N'AE2CE7DA',N'A81C7392',N'HH03',66.00000,405184.00000,26742144.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1737,N'7ADBC2AE',N'01734809',N'A92',38.00000,425973.00000,16186974.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1738,N'7ADBC2AE',N'80815157',N'NVL03',79.00000,447507.00000,35353053.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1739,N'7ADBC2AE',N'65353581',N'TP03',38.00000,149240.00000,5671120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1740,N'7ADBC2AE',N'6B903D25',N'NVL03',38.00000,954536.00000,36272368.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1741,N'DE7DBAA2',N'93AD4DD0',N'A92',80.00000,460518.00000,36841440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1742,N'DE7DBAA2',N'681BCF2B',N'NVL03',94.00000,515309.00000,48439046.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1743,N'2E80934D',N'BB48C141',N'A95',28.00000,246081.00000,6890268.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1744,N'2E80934D',N'52F88C44',N'HH03',60.00000,120137.00000,7208220.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1745,N'2E80934D',N'67EC2BD7',N'TP03',64.00000,191954.00000,12285056.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1746,N'0FA6BF57',N'697B3878',N'A95',60.00000,177081.00000,10624860.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1747,N'0FA6BF57',N'2E2CD3F0',N'HH03',56.00000,183907.00000,10298792.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1748,N'0FA6BF57',N'DE799786',N'DIESEL',55.00000,299354.00000,16464470.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1749,N'0FA6BF57',N'F5597B62',N'NVL03',33.00000,175452.00000,5789916.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1750,N'0FA6BF57',N'A2330929',N'NVL02',88.00000,952689.00000,83836632.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1751,N'397EEA54',N'FC7192A9',N'NVL02',77.00000,431738.00000,33243826.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1752,N'397EEA54',N'4BBC9324',N'NVL03',17.00000,485889.00000,8260113.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1753,N'4EF82999',N'419FFFD1',N'TP01',35.00000,183388.00000,6418580.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1754,N'4EF82999',N'6441B112',N'DIESEL',30.00000,1064241.00000,31927230.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1755,N'00891C81',N'ED38D2DA',N'A95',65.00000,715516.00000,46508540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1756,N'00891C81',N'AC3B31E0',N'HH02',37.00000,782877.00000,28966449.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1757,N'00891C81',N'312316AA',N'HH02',33.00000,742912.00000,24516096.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1758,N'00891C81',N'DD846485',N'TP01',56.00000,516866.00000,28944496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1759,N'00891C81',N'B0891808',N'NVL02',45.00000,755798.00000,34010910.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1760,N'00891C81',N'22E904E5',N'NVL03',40.00000,885714.00000,35428560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1761,N'D8D711CD',N'C837A0D1',N'TP02',90.00000,602633.00000,54236970.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1762,N'D8D711CD',N'FDE680B8',N'A95',39.00000,607498.00000,23692422.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1763,N'D8D711CD',N'D008F021',N'HH03',25.00000,517899.00000,12947475.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1764,N'42274C08',N'F1C30090',N'TP02',7.00000,1017863.00000,7125041.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1765,N'42274C08',N'E83F08EF',N'HH01',67.00000,1008024.00000,67537608.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1766,N'42274C08',N'7A71449C',N'NVL03',72.00000,396082.00000,28517904.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1767,N'42274C08',N'73D18E98',N'TP03',48.00000,939572.00000,45099456.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1768,N'42274C08',N'501480F5',N'A95',29.00000,608480.00000,17645920.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1769,N'51DCF99F',N'5CB64FD0',N'TP02',76.00000,604636.00000,45952336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1770,N'51DCF99F',N'2FED9D2A',N'NVL02',95.00000,639679.00000,60769505.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1771,N'51DCF99F',N'388AC607',N'TP01',86.00000,781157.00000,67179502.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1772,N'51DCF99F',N'F8E50BF5',N'NVL03',47.00000,379905.00000,17855535.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1773,N'51DCF99F',N'AE87C8E1',N'HH02',76.00000,129587.00000,9848612.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1774,N'711467BD',N'1213ED27',N'TP03',10.00000,903503.00000,9035030.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1775,N'711467BD',N'C81BFEC8',N'HH01',14.00000,552102.00000,7729428.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1776,N'711467BD',N'45CF77B9',N'DIESEL',46.00000,271973.00000,12510758.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1777,N'711467BD',N'7F95C6E0',N'A92',23.00000,744214.00000,17116922.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1778,N'3A14A003',N'6F393AA4',N'DIESEL',17.00000,749860.00000,12747620.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1779,N'3A14A003',N'B6AB963E',N'TP03',4.00000,352293.00000,1409172.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1780,N'3A14A003',N'2B938592',N'HH03',52.00000,583754.00000,30355208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1781,N'C881765D',N'942562B8',N'TP03',95.00000,1044255.00000,99204225.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1782,N'C881765D',N'3A10801F',N'DIESEL',70.00000,1030965.00000,72167550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1783,N'ED24AC8A',N'438B946D',N'NVL03',71.00000,424767.00000,30158457.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1784,N'BDEE1C9D',N'1E677B54',N'NVL02',20.00000,476923.00000,9538460.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1785,N'BDEE1C9D',N'E87A1CCB',N'NVL02',24.00000,629769.00000,15114456.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1786,N'BDEE1C9D',N'E6FA10D6',N'DIESEL',14.00000,529958.00000,7419412.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1787,N'BDEE1C9D',N'2D96503C',N'TP02',92.00000,362242.00000,33326264.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1788,N'C6D825BA',N'68B00339',N'DIESEL',100.00000,995801.00000,99580100.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1789,N'C6D825BA',N'E65441C4',N'HH03',16.00000,453416.00000,7254656.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1790,N'2C69BFE7',N'CB5427B1',N'A95',35.00000,246065.00000,8612275.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1791,N'2C69BFE7',N'C17CBB3F',N'A95',20.00000,435547.00000,8710940.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1792,N'931AE1F7',N'3D3C6720',N'NVL03',48.00000,1028893.00000,49386864.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1793,N'931AE1F7',N'A47460CB',N'TP01',38.00000,1034268.00000,39302184.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1794,N'931AE1F7',N'FB7C0415',N'A92',82.00000,707269.00000,57996058.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1795,N'931AE1F7',N'CFABF735',N'DIESEL',93.00000,915229.00000,85116297.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1796,N'4D3B16CF',N'E9108423',N'TP02',74.00000,477173.00000,35310802.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1797,N'4D3B16CF',N'98E86DCF',N'NVL02',74.00000,393235.00000,29099390.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1798,N'4D3B16CF',N'D7D47243',N'A95',38.00000,967870.00000,36779060.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1799,N'4D3B16CF',N'7FE7856F',N'NVL01',96.00000,1021403.00000,98054688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1800,N'4D3B16CF',N'B72324F9',N'HH01',84.00000,620492.00000,52121328.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1801,N'4D3B16CF',N'E658CAEF',N'NVL02',88.00000,308205.00000,27122040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1802,N'03B3502E',N'FE7BB731',N'TP03',55.00000,493792.00000,27158560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1803,N'03B3502E',N'9C62ABA2',N'TP01',32.00000,806641.00000,25812512.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1804,N'03B3502E',N'4496A53A',N'TP01',59.00000,166396.00000,9817364.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1805,N'43E75264',N'D910291F',N'HH01',61.00000,664784.00000,40551824.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1806,N'43E75264',N'61AA7711',N'HH01',66.00000,871793.00000,57538338.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1807,N'43E75264',N'BE5E7D24',N'TP01',66.00000,719966.00000,47517756.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1808,N'58062D8C',N'047D922C',N'A92',55.00000,693909.00000,38164995.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1809,N'58062D8C',N'1EF3A0C0',N'NVL01',8.00000,388581.00000,3108648.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1810,N'58062D8C',N'22D50568',N'TP02',2.00000,328714.00000,657428.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1811,N'5A384195',N'296225D6',N'NVL02',63.00000,683849.00000,43082487.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1812,N'5A384195',N'C2695407',N'DIESEL',19.00000,183801.00000,3492219.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1813,N'5A384195',N'19E3E442',N'TP03',30.00000,299647.00000,8989410.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1814,N'5A384195',N'F29462D2',N'HH03',68.00000,167216.00000,11370688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1815,N'A43C7BB4',N'D1A0CA98',N'TP03',73.00000,215301.00000,15716973.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1816,N'A43C7BB4',N'6820D7DE',N'TP01',30.00000,788138.00000,23644140.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1817,N'A43C7BB4',N'D3BAD452',N'TP03',24.00000,1018453.00000,24442872.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1818,N'A43C7BB4',N'66C1A054',N'HH02',58.00000,291098.00000,16883684.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1819,N'0569F182',N'0ED9063A',N'HH01',80.00000,543771.00000,43501680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1820,N'0569F182',N'165BE345',N'A92',87.00000,533148.00000,46383876.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1821,N'0569F182',N'E3DF2C14',N'NVL02',79.00000,121450.00000,9594550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1822,N'97633B20',N'28249CF7',N'HH02',29.00000,200322.00000,5809338.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1823,N'97633B20',N'443996C4',N'DIESEL',94.00000,628325.00000,59062550.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1824,N'CDCE4D18',N'9CBFE332',N'TP02',29.00000,770201.00000,22335829.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1825,N'CDCE4D18',N'9B2AB0F1',N'TP01',83.00000,816385.00000,67759955.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1826,N'CDCE4D18',N'1382FE97',N'TP02',65.00000,872925.00000,56740125.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1827,N'CDCE4D18',N'C598591F',N'HH02',87.00000,673086.00000,58558482.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1828,N'CDCE4D18',N'BFF9FEEE',N'A95',29.00000,234165.00000,6790785.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1829,N'09DB91AF',N'DFBB989E',N'TP03',40.00000,930414.00000,37216560.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1830,N'09DB91AF',N'A5A59906',N'NVL01',39.00000,766265.00000,29884335.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1831,N'09DB91AF',N'9F957DA6',N'HH03',42.00000,657624.00000,27620208.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1832,N'09DB91AF',N'67EF43AD',N'A95',20.00000,425957.00000,8519140.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1833,N'09DB91AF',N'41B72746',N'NVL01',88.00000,830978.00000,73126064.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1834,N'9D3D436C',N'ECFF7673',N'NVL01',61.00000,688352.00000,41989472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1835,N'9D3D436C',N'234260DA',N'HH01',72.00000,303305.00000,21837960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1836,N'9D3D436C',N'59D7268E',N'A95',34.00000,737678.00000,25081052.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1837,N'A7950434',N'706A8FDE',N'NVL03',68.00000,874931.00000,59495308.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1838,N'A7950434',N'6EF16BB7',N'HH03',42.00000,294541.00000,12370722.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1839,N'A7950434',N'2F4EC8A2',N'HH01',42.00000,699314.00000,29371188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1840,N'A7950434',N'F06FFE60',N'NVL02',62.00000,715230.00000,44344260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1841,N'9C41B9AF',N'71635931',N'HH01',3.00000,405303.00000,1215909.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1842,N'9C41B9AF',N'37F04C2A',N'HH03',89.00000,625628.00000,55680892.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1843,N'9C41B9AF',N'3076B701',N'TP02',17.00000,446459.00000,7589803.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1844,N'9C41B9AF',N'67B941DF',N'A92',36.00000,678726.00000,24434136.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1845,N'21F25DC7',N'B684B5FA',N'DIESEL',62.00000,793227.00000,49180074.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1846,N'21F25DC7',N'11880BA3',N'A92',21.00000,223451.00000,4692471.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1847,N'821AFF1C',N'4DB4E47F',N'A92',95.00000,980251.00000,93123845.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1848,N'821AFF1C',N'C3B3EA46',N'NVL01',12.00000,1094857.00000,13138284.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1849,N'821AFF1C',N'03C344DE',N'DIESEL',20.00000,341935.00000,6838700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1850,N'821AFF1C',N'5055EE04',N'A95',37.00000,207226.00000,7667362.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1851,N'84B183A3',N'13D8D4C0',N'NVL03',50.00000,241587.00000,12079350.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1852,N'84B183A3',N'206766D8',N'A92',89.00000,950480.00000,84592720.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1853,N'84B183A3',N'078B6452',N'TP02',63.00000,111630.00000,7032690.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1854,N'84B183A3',N'2F419050',N'HH03',58.00000,627389.00000,36388562.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1855,N'A99E6799',N'81FB5DC4',N'NVL03',74.00000,305856.00000,22633344.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1856,N'A99E6799',N'36C0B73E',N'HH01',47.00000,990725.00000,46564075.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1857,N'A99E6799',N'A426958F',N'A95',21.00000,565288.00000,11871048.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1858,N'46651EA1',N'0CE85DCD',N'A95',9.00000,386849.00000,3481641.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1859,N'46651EA1',N'BDAEC86C',N'HH03',78.00000,1071151.00000,83549778.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1860,N'20C44D96',N'73748C68',N'DIESEL',4.00000,1036570.00000,4146280.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1861,N'642FFEF2',N'EBC12E78',N'TP02',33.00000,968532.00000,31961556.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1862,N'642FFEF2',N'3F794C54',N'TP01',4.00000,115701.00000,462804.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1863,N'642FFEF2',N'C66903FC',N'HH03',10.00000,560469.00000,5604690.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1864,N'642FFEF2',N'58704C5E',N'HH01',45.00000,237418.00000,10683810.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1865,N'1DBD46AA',N'588EDF42',N'HH02',14.00000,547186.00000,7660604.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1866,N'1DBD46AA',N'7F9310DA',N'TP03',101.00000,1046652.00000,105711852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1867,N'1DBD46AA',N'EF382E9A',N'TP02',36.00000,1088736.00000,39194496.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1868,N'B47734D8',N'910C4446',N'HH02',36.00000,538013.00000,19368468.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1869,N'B47734D8',N'1AD914C5',N'A92',43.00000,466086.00000,20041698.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1870,N'B47734D8',N'945C2455',N'A95',19.00000,736852.00000,14000188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1871,N'B47734D8',N'012572E2',N'NVL01',39.00000,869108.00000,33895212.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1872,N'B47734D8',N'059170DE',N'HH02',76.00000,132374.00000,10060424.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1873,N'B47734D8',N'2CFD0F59',N'DIESEL',46.00000,559227.00000,25724442.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1874,N'57BE2643',N'C8F795AC',N'NVL02',81.00000,781492.00000,63300852.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1875,N'57BE2643',N'A9177375',N'HH03',95.00000,850307.00000,80779165.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1876,N'F1DDF4AE',N'817AD87D',N'HH03',38.00000,1010172.00000,38386536.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1877,N'F1DDF4AE',N'1BE237F9',N'A92',98.00000,498111.00000,48814878.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1878,N'41CFA24B',N'423DF891',N'HH03',7.00000,486889.00000,3408223.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1879,N'41CFA24B',N'506432F9',N'TP03',42.00000,948721.00000,39846282.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1880,N'41CFA24B',N'26CF9D68',N'A92',20.00000,932542.00000,18650840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1881,N'56FFE0AC',N'B48D9B7C',N'DIESEL',78.00000,338978.00000,26440284.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1882,N'56FFE0AC',N'6882924E',N'HH02',80.00000,472494.00000,37799520.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1883,N'FA5B67A3',N'3C8FA18E',N'HH01',99.00000,288625.00000,28573875.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1884,N'FA5B67A3',N'8B4AFBEE',N'A95',97.00000,972904.00000,94371688.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1885,N'FA5B67A3',N'2973160D',N'A95',23.00000,692937.00000,15937551.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1886,N'FA5B67A3',N'27FBF912',N'NVL02',37.00000,1001296.00000,37047952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1887,N'FA5B67A3',N'B599CC7B',N'HH02',46.00000,906236.00000,41686856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1888,N'FA5B67A3',N'3245CC0A',N'HH01',99.00000,621231.00000,61501869.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1889,N'71134948',N'FF8A4C89',N'NVL01',65.00000,1025323.00000,66645995.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1890,N'71134948',N'0CE833CC',N'A95',37.00000,605007.00000,22385259.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1891,N'CFC11F8D',N'6A4E7852',N'NVL02',20.00000,452022.00000,9040440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1892,N'CFC11F8D',N'E9EB7A2F',N'TP01',2.00000,668826.00000,1337652.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1893,N'2480E899',N'980C9558',N'TP01',78.00000,619102.00000,48289956.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1894,N'2480E899',N'E1E80C65',N'TP01',54.00000,290123.00000,15666642.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1895,N'2480E899',N'90C53DC3',N'NVL03',9.00000,702793.00000,6325137.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1896,N'DE734DEA',N'A014E503',N'TP01',37.00000,791485.00000,29284945.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1897,N'DE734DEA',N'8D9C74BE',N'NVL01',58.00000,865947.00000,50224926.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1898,N'DE734DEA',N'50F52FEF',N'A92',16.00000,687484.00000,10999744.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1899,N'DE734DEA',N'AB134794',N'DIESEL',49.00000,317822.00000,15573278.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1900,N'DE734DEA',N'A8AACDD5',N'DIESEL',30.00000,1002081.00000,30062430.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1901,N'DE734DEA',N'B6F17BB1',N'NVL03',1.00000,969201.00000,969201.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1902,N'87AAC53F',N'02DDFBDF',N'HH01',84.00000,461938.00000,38802792.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1903,N'51AA7ABD',N'0988C620',N'NVL02',4.00000,1036278.00000,4145112.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1904,N'51AA7ABD',N'6D6FE951',N'A95',74.00000,1046959.00000,77474966.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1905,N'51AA7ABD',N'8B8A1896',N'TP01',66.00000,649314.00000,42854724.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1906,N'51AA7ABD',N'4DC4651B',N'HH03',45.00000,576076.00000,25923420.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1907,N'51AA7ABD',N'C9BD8851',N'TP03',40.00000,381874.00000,15274960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1908,N'51AA7ABD',N'AE615F97',N'A92',94.00000,942002.00000,88548188.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1909,N'7A319A32',N'3D068A05',N'HH01',37.00000,115468.00000,4272316.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1910,N'7A319A32',N'50B70CA4',N'TP02',42.00000,883850.00000,37121700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1911,N'7A319A32',N'CA8E5CEC',N'A92',60.00000,953884.00000,57233040.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1912,N'7A319A32',N'358AAE85',N'TP03',19.00000,459251.00000,8725769.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1913,N'BC3B9153',N'4F5B9DEF',N'HH01',96.00000,937603.00000,90009888.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1914,N'BC3B9153',N'4AC0AD31',N'NVL03',37.00000,145844.00000,5396228.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1915,N'90778F8F',N'5467ED12',N'TP03',98.00000,942432.00000,92358336.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1916,N'90778F8F',N'3BD78DD7',N'HH03',82.00000,599970.00000,49197540.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1917,N'ED876C2D',N'DED7EEC8',N'NVL02',92.00000,971834.00000,89408728.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1918,N'ED876C2D',N'37B094CC',N'A92',97.00000,790101.00000,76639797.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1919,N'ED876C2D',N'3632D3DE',N'TP03',50.00000,219545.00000,10977250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1920,N'ED876C2D',N'3CC80F5C',N'HH02',56.00000,764982.00000,42838992.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1921,N'ED876C2D',N'A96B7ED8',N'A95',60.00000,101297.00000,6077820.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1922,N'ED876C2D',N'2A6B0D3F',N'DIESEL',85.00000,823792.00000,70022320.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1923,N'9DEE3C27',N'3FD8884F',N'TP03',91.00000,711636.00000,64758876.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1924,N'9DEE3C27',N'77E00F67',N'TP01',17.00000,204309.00000,3473253.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1925,N'9DEE3C27',N'614128C0',N'DIESEL',80.00000,165676.00000,13254080.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1926,N'9DEE3C27',N'5090EB9B',N'HH02',40.00000,379096.00000,15163840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1927,N'9DEE3C27',N'75017DC9',N'HH01',100.00000,748682.00000,74868200.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1928,N'9C258883',N'A6AC3EB2',N'DIESEL',75.00000,528035.00000,39602625.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1929,N'9C258883',N'3AD15E22',N'TP03',49.00000,666250.00000,32646250.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1930,N'9C258883',N'32A693A4',N'TP03',35.00000,163420.00000,5719700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1931,N'6DC75FF5',N'72BE287E',N'TP03',92.00000,937596.00000,86258832.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1932,N'6DC75FF5',N'D1E0107D',N'TP03',92.00000,937112.00000,86214304.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1933,N'6DC75FF5',N'30F0275A',N'NVL03',25.00000,506735.00000,12668375.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1934,N'4E3445C7',N'1E0C4222',N'TP02',81.00000,595999.00000,48275919.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1935,N'4E3445C7',N'43B90B90',N'TP02',25.00000,184920.00000,4623000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1936,N'4E3445C7',N'206E086E',N'HH03',22.00000,332467.00000,7314274.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1937,N'DCDA216B',N'066A4ED3',N'TP01',77.00000,363489.00000,27988653.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1938,N'DCDA216B',N'E45F8ADF',N'TP01',42.00000,214969.00000,9028698.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1939,N'DCDA216B',N'65CBFF67',N'DIESEL',4.00000,623173.00000,2492692.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1940,N'DCDA216B',N'43973C7A',N'TP02',3.00000,449864.00000,1349592.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1941,N'4354E48D',N'D27D9BE9',N'TP03',12.00000,516094.00000,6193128.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1942,N'17812C07',N'E0DD05E5',N'DIESEL',70.00000,630164.00000,44111480.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1943,N'17812C07',N'691114F4',N'HH03',9.00000,908955.00000,8180595.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1944,N'17812C07',N'F5F4DD94',N'TP03',70.00000,660919.00000,46264330.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1945,N'4ED1369F',N'C605E11D',N'TP03',32.00000,817663.00000,26165216.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1946,N'4ED1369F',N'2D52876E',N'TP03',77.00000,499890.00000,38491530.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1947,N'4ED1369F',N'C8187881',N'A95',58.00000,600106.00000,34806148.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1948,N'07C32023',N'89F15DFD',N'HH02',5.00000,675540.00000,3377700.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1949,N'A366A708',N'9601D2B5',N'TP01',23.00000,985394.00000,22664062.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1950,N'7E597302',N'6CB9B093',N'HH02',48.00000,922539.00000,44281872.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1951,N'7E597302',N'068709AD',N'NVL02',75.00000,567860.00000,42589500.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1952,N'7E597302',N'5C9F9D47',N'HH02',27.00000,135919.00000,3669813.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1953,N'7E597302',N'7BE0BCCE',N'TP01',11.00000,930878.00000,10239658.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1954,N'7E597302',N'9687F378',N'TP02',94.00000,1080057.00000,101525358.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1955,N'281DD2AB',N'7EFC4E03',N'DIESEL',34.00000,129282.00000,4395588.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1956,N'281DD2AB',N'92D76E60',N'DIESEL',88.00000,746806.00000,65718928.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1957,N'281DD2AB',N'F1F289BE',N'HH02',24.00000,584128.00000,14019072.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1958,N'281DD2AB',N'3972EAD0',N'A95',9.00000,151359.00000,1362231.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1959,N'4DD21608',N'20393E23',N'NVL03',88.00000,931841.00000,82002008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1960,N'4DD21608',N'B4AEDAF2',N'NVL03',24.00000,1076183.00000,25828392.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1961,N'4DD21608',N'E9374BCB',N'NVL01',18.00000,266153.00000,4790754.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1962,N'4DD21608',N'8D67F904',N'TP02',31.00000,717598.00000,22245538.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1963,N'2F71D447',N'D1F2C614',N'NVL03',35.00000,200656.00000,7022960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1964,N'2175F5C6',N'69BA7FF5',N'TP03',90.00000,609376.00000,54843840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1965,N'2175F5C6',N'1DC87528',N'TP03',40.00000,511375.00000,20455000.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1966,N'2175F5C6',N'C4D005A1',N'HH01',25.00000,550252.00000,13756300.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1967,N'2175F5C6',N'7F45619E',N'DIESEL',53.00000,296472.00000,15713016.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1968,N'2175F5C6',N'8BF7096D',N'HH03',3.00000,723925.00000,2171775.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1969,N'8D3406F0',N'3A598212',N'NVL03',51.00000,1044582.00000,53273682.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1970,N'8D3406F0',N'297C531D',N'DIESEL',8.00000,313607.00000,2508856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1971,N'8D3406F0',N'657A8B5A',N'DIESEL',97.00000,875821.00000,84954637.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1972,N'8D3406F0',N'E6EE3592',N'TP02',64.00000,824593.00000,52773952.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1973,N'8D3406F0',N'8F5DCA6F',N'NVL02',80.00000,592817.00000,47425360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1974,N'814D24A1',N'B16F5AF6',N'A95',53.00000,358676.00000,19009828.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1975,N'814D24A1',N'FCB46BF0',N'HH01',60.00000,313078.00000,18784680.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1976,N'814D24A1',N'EE263785',N'TP01',36.00000,916528.00000,32995008.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1977,N'814D24A1',N'17B59FCF',N'DIESEL',12.00000,525956.00000,6311472.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1978,N'814D24A1',N'0364415E',N'A92',46.00000,365083.00000,16793818.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1979,N'814D24A1',N'C314C3A2',N'TP03',36.00000,452785.00000,16300260.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1980,N'EEFC1DDF',N'4A48C66A',N'HH01',59.00000,654370.00000,38607830.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1981,N'EEFC1DDF',N'A3A8426C',N'DIESEL',19.00000,596708.00000,11337452.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1982,N'EEFC1DDF',N'EFA0B555',N'NVL02',59.00000,217460.00000,12830140.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1983,N'EEFC1DDF',N'BA6A3E2F',N'TP02',26.00000,714661.00000,18581186.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1984,N'84DF742B',N'5DD2CD84',N'A95',56.00000,287438.00000,16096528.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1985,N'84DF742B',N'0D233EDE',N'HH03',89.00000,867405.00000,77199045.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1986,N'84DF742B',N'39570A69',N'HH01',56.00000,421641.00000,23611896.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1987,N'5499F724',N'BA3347B1',N'HH02',46.00000,725481.00000,33372126.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1988,N'5499F724',N'568662FF',N'HH01',19.00000,865293.00000,16440567.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1989,N'5499F724',N'AA84BDC9',N'A95',69.00000,314413.00000,21694497.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1990,N'51F1E19E',N'37DFE1A2',N'TP01',86.00000,1068002.00000,91848172.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1991,N'51F1E19E',N'4DD3509E',N'TP01',70.00000,1088425.00000,76189750.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1992,N'D16ACA0F',N'33BCAC51',N'HH02',13.00000,132605.00000,1723865.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1993,N'D16ACA0F',N'15F0CAE2',N'A95',98.00000,591780.00000,57994440.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1994,N'D16ACA0F',N'438A8F61',N'TP02',95.00000,816251.00000,77543845.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1995,N'ECD3E33B',N'6CA5FFF3',N'HH01',84.00000,760101.00000,63848484.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1996,N'ECD3E33B',N'18AAAABB',N'NVL03',63.00000,343410.00000,21634830.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1997,N'07EEF718',N'58116C72',N'NVL03',52.00000,293966.00000,15286232.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1998,N'07EEF718',N'9EA2BF00',N'TP02',19.00000,180496.00000,3429424.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 1999,N'07EEF718',N'87494532',N'DIESEL',95.00000,263155.00000,24999725.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2000,N'B44BDB63',N'EAED0269',N'TP01',31.00000,343153.00000,10637743.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2001,N'B44BDB63',N'6B481A60',N'NVL02',31.00000,253167.00000,7848177.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2002,N'B44BDB63',N'097EAB4B',N'NVL02',89.00000,752591.00000,66980599.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2003,N'B44BDB63',N'84C73F9F',N'A92',24.00000,298039.00000,7152936.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2004,N'B44BDB63',N'46852C80',N'HH03',42.00000,723607.00000,30391494.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2005,N'87CA4C53',N'6B1111BA',N'A95',16.00000,168835.00000,2701360.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2006,N'87CA4C53',N'C427D6FA',N'A92',52.00000,537667.00000,27958684.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2007,N'EEDF79E1',N'1FAA69D8',N'TP01',72.00000,745970.00000,53709840.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2008,N'EEDF79E1',N'7393342B',N'HH03',60.00000,1099302.00000,65958120.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2009,N'EEDF79E1',N'2E204F99',N'HH01',62.00000,225145.00000,13958990.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2010,N'EEDF79E1',N'C0A44D04',N'A95',42.00000,369380.00000,15513960.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2011,N'EEDF79E1',N'0674B514',N'A92',56.00000,1092342.00000,61171152.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2012,N'D5C628A7',N'37DF2A37',N'TP01',32.00000,400808.00000,12825856.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2013,N'D5C628A7',N'F0C9BDBC',N'TP02',84.00000,291401.00000,24477684.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2014,N'D5C628A7',N'F7D34B19',N'TP03',15.00000,883366.00000,13250490.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2015,N'707B3B64',N'2264F99B',N'HH01',79.00000,214945.00000,16980655.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2016,N'84D4EED5',N'CF93ECF1',N'A92',46.00000,546929.00000,25158734.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2017,N'84D4EED5',N'91C5B99C',N'TP03',12.00000,851759.00000,10221108.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2018,N'84D4EED5',N'FC5EDD40',N'NVL03',11.00000,258614.00000,2844754.00
INSERT INTO [DocDetail] ([Id],[DocId],[RowId],[ItemCode],[Quantity],[UnitCost],[Amount] )  SELECT 2019,N'84D4EED5',N'FC5EDD4Q',N'Q1',11.00000,258614.00000,2844754.00
GO
SET IDENTITY_INSERT dbo.[DocDetail] OFF
GO


SELECT * FROM dbo.Customer
SELECT * FROM dbo.Item
SELECT * FROM dbo.Warehouse
SELECT * FROM dbo.OpenWarehouse
SELECT * FROM dbo.Doc
SELECT * FROM dbo.DocDetail