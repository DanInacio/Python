USE [DSTraining]
GO
/****** Object:  StoredProcedure [dbo].[__tmpl__BLD_WRK_TableName]    Script Date: 19/01/2021 14:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[__tmpl__BLD_WRK_TableName]
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
IF OBJECT_ID('WRK_TableName') IS NOT NULL
DROP TABLE [WRK_TableName]

-- =============================================
-- CREATE TABLE Block
-- =============================================
CREATE TABLE [WRK_TableName]
(
	[RowNumber] INT IDENTITY(1,1),
	[AAA] VARCHAR(100),
	[BBB] VARCHAR(1000),
	[DDD] DATE,
    [EEE] INT,
    [FFF] FLOAT
)

-- =============================================
-- TRUNCATE TABLE Block
-- =============================================
TRUNCATE TABLE [WRK_TableName]


-- =============================================
-- INSERT INTO Block
-- =============================================
INSERT INTO [WRK_TableName]
(	
	[AAA],
	[BBB],
	[DDD],
	[EEE],
	[FFF]
)
SELECT	[xAAA],
		[xBBB],
		CONVERT(DATE,[XDDD],20) AS 'COL.TITLE',
		CAST([xEEE] AS INT) AS 'COL.TITLE',
		CAST([xFFF] AS FLOAT) AS 'COL.TITLE'
FROM [RAW_WRK_TableName_YYYYMMDD]
-- xxx rows affected

END
