SELECT od.ProductID
	,p.[Name]
	,SUM(od.LineTotal) AS SalesOriginalCurrency
	,fx.AverageRate
	,(SUM(od.LineTotal) * fx.AverageRate) AS SalesUSD
FROM Sales.SalesOrderDetail AS od
INNER JOIN Production.Product AS p ON od.ProductID = p.ProductID
INNER JOIN Sales.SalesOrderHeader AS oh ON od.SalesOrderID = oh.SalesOrderID
LEFT JOIN Sales.CurrencyRate AS fx ON oh.CurrencyRateID = fx.CurrencyRateID
GROUP BY od.ProductID
	,p.[Name]
	,fx.AverageRate