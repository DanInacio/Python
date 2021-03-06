USE [DSTraining]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_P12-TransactionalData]    Script Date: 19/01/2021 13:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_P12-TransactionalData]
-- =============================================
-- Author:		Daniel Inacio
-- Create date: 20210117
-- Description:	RAW -> WRK
-- =============================================
AS
BEGIN

-- =============================================
-- IF EXISTS DROP TABLE Block
-- =============================================
IF OBJECT_ID('WRK_OfficeSupplies_TransactionalData') IS NOT NULL
DROP TABLE [WRK_OfficeSupplies_TransactionalData]

-- =============================================
-- CREATE TABLE Block
-- =============================================
CREATE TABLE [WRK_OfficeSupplies_TransactionalData]
(
	[RowNumber] INT IDENTITY(1,1),
	[Order ID] VARCHAR(100),
	[Order Date] DATE,
    [Customer ID] VARCHAR(100),
    [Region] VARCHAR(1),
    [Rep] VARCHAR(100),
    [Item] VARCHAR(1000),
    [Units] INT,
    [Unit Price] FLOAT
)

-- =============================================
-- TRUNCATE TABLE Block
-- =============================================
TRUNCATE TABLE [WRK_OfficeSupplies_TransactionalData]


-- =============================================
-- INSERT INTO Block
-- =============================================
INSERT INTO [WRK_OfficeSupplies_TransactionalData]
(	
	[Order ID],
	[Order Date],
	[Customer ID],
	[Region],
	[Rep],
	[Item],
	[Units],
	[Unit Price]
)
SELECT	[Order ID],
		CONVERT(DATE,[Order Date],20) AS 'Order Date',
		[Customer ID],
		[Region],
		[Rep],
	    [Item],
		CAST([Units] AS INT) AS 'Units',
		CAST([Unit Price] AS FLOAT) AS 'Unit Price'
FROM [RAW_P12-TransactionalData_20210117]
--43 rows affected

END
