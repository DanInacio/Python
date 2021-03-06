USE [DSTraining]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_P12-CustomerList]    Script Date: 19/01/2021 13:32:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_P12-CustomerList]
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
IF OBJECT_ID('WRK_OfficeSupplies_CustomerList') IS NOT NULL
DROP TABLE [WRK_OfficeSupplies_CustomerList]

-- =============================================
-- CREATE TABLE Block
-- =============================================
CREATE TABLE [WRK_OfficeSupplies_CustomerList]
(
	[RowNumber] INT IDENTITY(1,1),
	[Customer ID] VARCHAR(100),
	[City] VARCHAR(1000),
	[ZipCode] VARCHAR(5),
	[Gender] VARCHAR(1),
	[Age] FLOAT
)

-- =============================================
-- TRUNCATE TABLE Block
-- =============================================
TRUNCATE TABLE [WRK_OfficeSupplies_CustomerList]


-- =============================================
-- INSERT INTO Block
-- =============================================
INSERT INTO [WRK_OfficeSupplies_CustomerList]
(	
	[Customer ID],
	[City],
	[ZipCode],
	[Gender],
	[Age]
)
SELECT	RIGHT('0000000'+[Customer ID],7),
		[City],
		[ZipCode],
		[Gender],
		[Age]
FROM [RAW_P12-CustomerList_20210117]
--43 rows affected

END
