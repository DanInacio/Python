USE [DSTraining]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_FakeNamesCanada]    Script Date: 19/01/2021 14:44:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_FakeNamesCanada]
-- =============================================
-- Author:		Daniel Inacio
-- Create date: 19/01/2021
-- Description:	RAW -> WRK
-- =============================================
AS
BEGIN

-- =============================================
-- IF EXISTS DROP TABLE Block
-- =============================================
IF OBJECT_ID('WRK_FakeNamesCanada') IS NOT NULL
DROP TABLE [WRK_FakeNamesCanada]

-- =============================================
-- CREATE TABLE Block
-- =============================================
CREATE TABLE [WRK_FakeNamesCanada]
(
	[RowNumber] INT IDENTITY(1,1),
	[Number] VARCHAR(100),
    [Gender] VARCHAR(10),
    [GivenName] VARCHAR(1000),
    [Surname] VARCHAR(1000),
    [StreetAddress] VARCHAR(1000),
    [City] VARCHAR(1000),
    [ZipCode] VARCHAR(7),
    [CountryFull] VARCHAR(100),
    [Birthday] DATE,
    [Balance] FLOAT,
    [InterestRate] FLOAT
)

-- =============================================
-- TRUNCATE TABLE Block
-- =============================================
TRUNCATE TABLE [WRK_FakeNamesCanada]


-- =============================================
-- INSERT INTO Block
-- =============================================
INSERT INTO [WRK_FakeNamesCanada]
(	
	[Number],
    [Gender],
    [GivenName],
    [Surname],
    [StreetAddress],
    [City],
    [ZipCode],
    [CountryFull],
    --[Birthday],
    [Balance],
    [InterestRate]
)
SELECT
	[Number],
    [Gender],
    [GivenName],
    [Surname],
    [StreetAddress],
    [City],
    [ZipCode],
    [CountryFull],
    --[Birthday],
    [Balance],
    [InterestRate]
FROM [RAW_FakeNamesCanada_20210119]
--FILTERS:
WHERE ISNUMERIC([Balance]) = 1 -- 10 ROWS are non-numeric
AND   LEN([ZipCode]) <= 7      -- 02 ROWS are longer than expected
--AND	  LEN([Birthday]) = 10     -- 02 ROWS are with wrong date format
-- Did not use ISDATE due to system region differences!
-- Did not import Birthday due to system region differences!
-- 199983 ROWS have been inserted!

-- =============================================
-- ADDITIONAL QA CHECKS for Exclusions
-- =============================================
DELETE FROM WRK_FakeNamesCanada
WHERE Balance < 0
-- 1 ROW was affected

DELETE FROM WRK_FakeNamesCanada
WHERE ZipCode NOT LIKE '___ ___'
-- 4 ROWS were affected

--DELETE FROM WRK_FakeNamesCanada
--WHERE [Birthday] < '1915-08-13' OR [Birthday] > '2005-08-13'
-- 1 ROW was affected - not used due to region constraints!



END
