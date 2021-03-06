USE [DSTraining]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_VehicleService]    Script Date: 20/01/2021 08:56:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_VehicleService]
-- =============================================
-- Author:		
-- Create date: 
-- Description:	RAW -> WRK
-- =============================================
AS
BEGIN

-- =============================================
-- IF EXISTS DROP TABLE Block
-- =============================================
IF OBJECT_ID('WRK_VehicleService') IS NOT NULL
DROP TABLE [WRK_VehicleService]

-- =============================================
-- CREATE TABLE Block
-- =============================================
CREATE TABLE [WRK_VehicleService]
(
	[RowNumber] INT IDENTITY(1,1),
	[CustomerID] VARCHAR(100),
	[CustomerSince] VARCHAR(100),
-- should be date but this was to avoid region issues
	[Vehicle] VARCHAR(100),
    [2014] FLOAT,
    [2015] FLOAT,
	[2016E] FLOAT
)

-- =============================================
-- TRUNCATE TABLE Block
-- =============================================
TRUNCATE TABLE [WRK_VehicleService]

-- =============================================
-- INSERT INTO Block
-- =============================================
INSERT INTO [WRK_VehicleService]
(	
	[CustomerID],
	[CustomerSince],
	[Vehicle],
    [2014],
    [2015],
	[2016E]
)
SELECT
	[CustomerID],
	[CustomerSince],
	[Vehicle],
    [2014],
    [2015],
	[2016E]
FROM [RAW_VehicleService_20210119]
WHERE ISNUMERIC([2014]) = 1 OR [2014] = ''
AND ISNUMERIC([2015]) = 1 OR [2015] = ''
AND ISNUMERIC([2016E]) = 1 OR [2016E] = ''
-- xxx rows affected

--  SELECT *
 -- FROM [DSTraining].[dbo].[RAW_VehicleService_20210119]
 -- WHERE ISNUMERIC([2015] ) = 0 AND [2015] <> ''

-- ADDITIONAL CHECKS

/* CustomerID CHECK
SELECT CustomerID, COUNT(*) FROM [WRK_VehicleService]
GROUP BY CustomerID
HAVING COUNT(*) > 1
-- CustomerID=3490750 shows up twice!

-- Not a duplicate row!!!
SELECT * FROM WRK_VehicleService
WHERE CustomerID='3490750'
*/

/* Date CHECK
SELECT * FROM WRK_VehicleService
WHERE CustomerSince < '01/01/1965'
*/

/* Value Outlier CHECK
SELECT AVG([2014]) FROM WRK_VehicleService
SELECT MAX([2014]) FROM WRK_VehicleService
SELECT AVG([2015]) FROM WRK_VehicleService
SELECT MAX([2015]) FROM WRK_VehicleService
SELECT AVG([2016E]) FROM WRK_VehicleService
SELECT MAX([2016E) FROM WRK_VehicleService
*/

/* SUM CHECK
SELECT SUM(2016E) FROM WRK_VehicleService
*/

END
