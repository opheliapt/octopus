WITH emp
(
	BusinessEntityID
	, OrgNode
	, Employee
)
AS 
(
	SELECT e.BusinessEntityID
		, e.OrganizationNode
		, p.FirstName + ' ' + p.LastName AS Employee
	FROM HumanResources.Employee AS e 
	INNER JOIN Person.Person AS p 	ON p.BusinessEntityID = e.BusinessEntityID
	WHERE e.BusinessEntityID = 1 --boss
	
	UNION ALL
	
	SELECT e.BusinessEntityID
		, e.OrganizationNode
		, p.FirstName + ' ' + p.LastName AS Employee
	FROM HumanResources.Employee AS e 
	INNER JOIN emp ON e.OrganizationNode.GetAncestor(1) = emp.OrgNode
	INNER JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
)
SELECT emp.BusinessEntityID
	, emp.Employee
	, emp.OrgNode.ToString() as OrgNode
	, p.FirstName + ' ' + p.LastName AS 'Manager'
FROM emp 
INNER JOIN HumanResources.Employee AS e ON emp.OrgNode.GetAncestor(1) = e.OrganizationNode
INNER JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
ORDER BY emp.OrgNode.ToString()

