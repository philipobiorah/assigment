--1. List all Suppliers in the UK

SELECT CompanyName, country FROM dbo.Supplier 
WHERE dbo.Supplier.Country = 'UK'

--2. List the first name, last name, and city for all customers. Concatenate the first and last name
--separated by a space and a comma as a single column
SELECT FirstName, LastName, City  , CONCAT(Firstname, ',' ,' ', LastName) AS CustomerName FROM dbo.Customer

--3. List all Customers in Sweden
SELECT * FROM dbo.Customer
WHERE Country = 'Sweden'

--4. List all suppliers in alphabetical order
SELECT * FROM dbo.Supplier
ORDER BY CompanyName ASC

--5. List all suppliers with their products
SELECT CompanyName, ProductName FROM dbo.Product AS P
JOIN dbo.Supplier AS S
ON P.SupplierID = S.Id

--6. List all orders with custormers information
SELECT FirstName, LastName, O.OrderDate, O.OrderNumber FROM [dbo].[Order] AS O
JOIN [dbo].[Customer] AS C 
ON O.CustomerID = C.Id

-- 7. List all orders with product name, quantity, and price, sorted by order number
SELECT OrderNumber, ProductName, Quantity, OI.UnitPrice  FROM [dbo].[Order] AS O 
JOIN dbo.OrderItem AS OI 
ON O.Id = OI.OrderId
JOIN dbo.Product AS P
ON OI.ProductId = P.Id
ORDER BY OrderNumber
-- 8. Using a case statement, list all the availability of products. When 0 then not available, else available
SELECT ProductName,
CASE WHEN IsDiscontinued = 0 THEN 'not available'
ELSE  'available'
END AS Status
FROM Product
-- 9. Using case statement, list all the suppliers and the language they speak. The language they speak should be their country E.g if UK, then English
SELECT CompanyName, Country,
CASE 
    WHEN Country = 'Australia' THEN 'English'
        WHEN Country = 'Brazil' THEN 'Portuguese'
        WHEN Country = 'Canada' THEN 'English'
        WHEN Country = 'Denmark' THEN 'Danish'
        WHEN Country = 'Finland' THEN 'Finnish'
        WHEN Country = 'France' THEN 'French'
        WHEN Country = 'Germany' THEN 'German'
        WHEN Country = 'Italy' THEN 'Italian'
        WHEN Country = 'Japan' THEN 'Japanese'
        WHEN Country = 'Netherlands' THEN 'Dutch'
        WHEN Country = 'Norway' THEN 'Norwegian'
        WHEN Country = 'Singapore' THEN 'English'
        WHEN Country = 'Spain' THEN 'Spanish'
        WHEN Country = 'Sweden' THEN 'Swedish'
        WHEN Country = 'UK' THEN 'English'
        WHEN Country = 'USA' THEN 'English'
        ELSE 'Unknown'
    END AS Lanugage

FROM Supplier
-- 10. List all products that are packaged in Jars
SELECT ProductName, Package FROM [dbo].[Product] 
WHERE Package LIKE '%jars'
-- 11. List procucts name, unitprice and packages for products that starts with Ca
SELECT ProductName, UnitPrice, Package FROM Product
WHERE ProductName LIKE 'Ca%'
-- 12. List the number of products for each supplier, sorted high to low.
SELECT S.CompanyName, COUNT(P.ProductName) AS NumberOfProducts
FROM dbo.Supplier AS S 
JOIN dbo.Product AS P 
ON P.SupplierId = S.Id
GROUP BY S.CompanyName
ORDER BY  NumberOfProducts DESC
-- 13. List the number of customers in each country.
SELECT Country, COUNT(*) AS Number_of_Customers FROM Customer
GROUP BY Country

-- 14. List the number of customers in each country, sorted high to low.
SELECT Country, COUNT(*) AS Number_of_Customers FROM Customer
GROUP BY Country
ORDER BY  Number_of_Customers DESC;
-- 15. List the total order amount for each customer, sorted high to low.
SELECT C.FirstName, C.LastName, SUM(O.TotalAmount) AS Total_Order_Amount
FROM dbo.Customer AS C 
JOIN [dbo].[Order] AS O
ON C.Id = O.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY Total_Order_Amount DESC
-- 16. List all countries with more than 2 suppliers.
SELECT Country, COUNT(*) AS Number_of_Supplers
FROM Supplier
GROUP BY Country
HAVING COUNT(*) > 2;

-- 17. List the number of customers in each country. Only include countries with more than 10 customers.
SELECT Country,  COUNT(*) AS No_of_Customers
FROM Customer
GROUP BY Country
HAVING COUNT(*) > 10

-- 18. List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers.
SELECT Country, COUNT(*) AS No_of_customers 
FROM Customer
WHERE Country != 'USA'
GROUP BY Country
HAVING COUNT (*) >= 9
ORDER BY No_of_customers

-- 19. List customer with average orders between $1000 and $1200.
SELECT FirstName, LastName, AVG(TotalAmount) AS AvergeOrders
FROM [dbo].Customer 
JOIN [dbo].[Order]
ON  dbo.Customer.Id = [dbo].[Order].CustomerId
GROUP BY FirstName, LastName
HAVING AVG(TotalAmount) BETWEEN 1000 AND 1200
-- 20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.

SELECT OrderDate, COUNT(*) AS No_of_orders, SUM(TotalAmount) AS TotalAmountSold
FROM [dbo].[Order]
WHERE [dbo].[Order].[OrderDate] BETWEEN '2013-01-01' AND '2013-01-31'
GROUP BY [dbo].[Order].[OrderDate]