DECLARE @startVersionSalesPerson INT
SET @startVersionSalesPerson = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Sales.SalesPerson'))

DECLARE @startVersionProduct INT
SET @startVersionProduct = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Production.Product'))

SELECT * 
FROM CHANGETABLE(CHANGES Sales.SalesPerson, @startVersionSalesPerson) AS SalesPersonChanges

SELECT * 
FROM CHANGETABLE(CHANGES Production.Product, 0) AS ProductChanges





