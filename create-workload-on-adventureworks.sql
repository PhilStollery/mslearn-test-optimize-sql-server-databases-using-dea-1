﻿USE [AdventureWorks2008R2]
GO

SET NOCOUNT ON

-- EXECUTE [dbo].[uspGetBillOfMaterials] MULTIPLE TIMES

DECLARE @ProductList table
(
	[RowID] int IDENTITY(1,1),
	[ProductID] int NOT NULL,
	[CheckDate] datetime NULL
) 
INSERT INTO @ProductList ([ProductID], [CheckDate])
SELECT	TOP 200 p.[ProductID], b.[StartDate]
FROM	[Production].[Product] AS p
LEFT	JOIN [Production].[BillOfMaterials] AS b ON p.[ProductID] = b.[ComponentID]
ORDER	BY [ProductID] 

DECLARE @Counter int
DECLARE @RowNumber int
DECLARE @ProductID int
DECLARE @CheckDate datetime

SELECT	@Counter = COUNT(*) FROM @ProductList
SET		@RowNumber = 1

WHILE @Counter > 0
BEGIN
	SELECT	@ProductID = [ProductID],
			@CheckDate = [CheckDate]
	FROM	@ProductList
	WHERE	[RowID] = @RowNumber

	EXEC [dbo].[uspGetBillOfMaterials]
	@StartProductID = @ProductID,
    @CheckDate = @CheckDate

	SET @RowNumber = @RowNumber + 1
	SET	@Counter = @Counter - 1
END
GO

-- SELECT FROM TABLES MULTIPLE TIMES

SELECT	*
FROM	[Sales].[Store]
GO 35

SELECT	*
FROM	[Sales].[SalesOrderHeader]
GO 35

SELECT	*
FROM	[Purchasing].[PurchaseOrderDetail]
GO 35

SELECT	*
FROM	[Sales].[Customer]
GO 35

SELECT	*
FROM	[Person].[Person]
GO 35
