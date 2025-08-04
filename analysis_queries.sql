-- Average invoice total per customer
SELECT CustomerID, AVG(TotalAmount) AS AvgTotal
FROM Invoices
GROUP BY CustomerID;

-- Customers who spent more than $100
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
  SELECT CustomerID FROM Invoices WHERE TotalAmount > 100
);

-- Items purchased more than once
SELECT ItemName, COUNT(*) AS PurchaseCount
FROM InvoiceItems
GROUP BY ItemName
HAVING COUNT(*) > 1;