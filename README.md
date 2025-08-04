# sql-dry-cleaning-db
SQL database design and query development for a dry-cleaning business.
Part I
Use dry_cleaning;
CREATE TABLE Customers (
    CustomerNumber INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Email VARCHAR(100)
);
CREATE TABLE Invoice (
    InvoiceNumber INT NOT NULL PRIMARY KEY,
    CustomerNumber INT NOT NULL,
    DateIn DATETIME NOT NULL,
    DateOut DATETIME,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerNumber) REFERENCES Customers(CustomerNumber)
);
CREATE TABLE Invoice_Item (
    ItemNumber INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceNumber INT NOT NULL,
    Item VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber)
);

SELECT * FROM dry_cleaning.customers;
INSERT INTO customers (CustomerNumber, FirstName, LastName, Phone, Email) VALUES
(1, 'Nikki', 'Kaccaton', '723-543-1233', 'Nikki.Kaccaton@somewhere.com'),
(2, 'Brenda', 'Catnazaro', '723-543-2344', 'Brenda.Catnazaro@somewhere.com'),
(3, 'Bruce', 'LeCat', '723-543-3455', 'Bruce.LeCat@somewhere.com'),
(4, 'Betsy', 'Miller', '725-654-3211', 'Betsy.Miller@somewhere.com'),
(5, 'George', 'Miller', '725-654-4322', 'George.Miller@somewhere.com'),
(6, 'Kathy', 'Miller', '723-514-9877', 'Kathy.Miller@somewhere.com'),
(7, 'Betsy', 'Miller', '723-514-8766', 'Betsy.Miller@elsewhere.com');

SELECT * FROM dry_cleaning.invoice;
INSERT INTO invoice (InvoiceNumber, CustomerNumber, DateIn, DateOut, TotalAmount) VALUES
(201101, 1, '2013-10-04', '2013-10-06', 158.50),
(201102, 2, '2013-10-04', '2013-10-06', 25.00),
(201103, 1, '2013-10-06', '2013-10-08', 49.00),
(201104, 4, '2013-10-06', '2013-10-08', 17.50),
(201105, 6, '2013-10-07', '2013-10-11', 12.00),
(201106, 3, '2013-10-11', '2013-10-13', 152.50),
(201107, 3, '2013-10-11', '2013-10-13', 7.00),
(201108, 7, '2013-10-12', '2013-10-14', 140.50),
(201109, 5, '2013-10-12', '2013-10-14', 27.00);

SELECT * FROM dry_cleaning.invoice_item;
INSERT INTO invoice_Item (ItemNumber, InvoiceNumber, Item, Quantity, UnitPrice) VALUES
(1, 201101, 'Blouse', 2, 3.50),
(2, 201101, 'Dress Shirt', 5, 2.50),
(3, 201101, 'Formal Gown', 2, 10.00),
(4, 201101, 'Slacks-Mens', 10, 5.00),
(5, 201101, 'Slacks-Womens', 10, 6.00),
(6, 201102, 'Suit-Mens', 1, 9.00),
(7, 201102, 'Dress Shirt', 10, 2.50),
(8, 201103, 'Slacks-Mens', 5, 5.00),
(9, 201103, 'Slacks-Womens', 4, 6.00),
(10, 201104, 'Dress Shirt', 7, 2.50),
(11, 201105, 'Blouse', 2, 3.50),
(12, 201105, 'Dress Shirt', 2, 2.50),
(13, 201106, 'Blouse', 5, 3.50),
(14, 201106, 'Dress Shirt', 10, 2.50),
(15, 201106, 'Slacks-Mens', 10, 5.00),
(16, 201106, 'Slacks-Womens', 10, 6.00),
(17, 201107, 'Blouse', 2, 3.50),
(18, 201108, 'Blouse', 3, 3.50),
(19, 201108, 'Dress Shirt', 12, 2.50),
(20, 201108, 'Slacks-Mens', 8, 5.00),
(21, 201108, 'Slacks-Womens', 10, 6.00),
(22, 201109, 'Suit-Mens', 3, 9.00);

-- 01CustomerPhone-LastName
SELECT Phone, LastName FROM Customers;

-- 02NikkiPhoneLastName
SELECT Phone, LastName FROM Customers WHERE FirstName = 'Nikki';

-- 03PhoneWith?23
SELECT Phone, FirstName, LastName
FROM Customers
WHERE Phone LIKE '_23%';

-- 04AverageTotalAmount
SELECT 
    MAX(TotalAmount) AS MaxTotalAmount, 
    MIN(TotalAmount) AS MinTotalAmount 
FROM Invoice;

-- 05CustomersTotalAmountGreaterThan100
SELECT FirstName, LastName
FROM Customers
WHERE CustomerNumber IN (
    SELECT CustomerNumber 
    FROM Invoice 
    WHERE TotalAmount > 100.00
)
ORDER BY LastName ASC, FirstName DESC;

-- 06CustomerLastFirstNamesConcatenated
SELECT 
    CONCAT(LastName, ', ', FirstName) AS "Full Name" 
FROM Customers;

-- 07FirstLastNamesDressShirtSortedLastName
SELECT FirstName, LastName
FROM Customers
WHERE CustomerNumber IN (
    SELECT DISTINCT CustomerNumber
    FROM Invoice
    WHERE InvoiceNumber IN (
        SELECT InvoiceNumber
        FROM Invoice_Item
        WHERE Item = 'Dress Shirt'
    )
)
ORDER BY LastName ASC;

-- 08FirstLastNamesDressShirtSortedFirstNameDescending
SELECT FirstName, LastName
FROM Customers
WHERE CustomerNumber IN (
    SELECT DISTINCT CustomerNumber
    FROM Invoice
    WHERE InvoiceNumber IN (
        SELECT InvoiceNumber
        FROM Invoice_Item
        WHERE Item = 'Dress Shirt'
    )
)
ORDER BY FirstName DESC;

-- 09FirstLastNamesDressShirtSortedLastNameWithTotal
SELECT c.FirstName, c.LastName, i.TotalAmount
FROM Customers c
JOIN Invoice i ON c.CustomerNumber = i.CustomerNumber
WHERE i.InvoiceNumber IN (
    SELECT InvoiceNumber
    FROM Invoice_Item
    WHERE Item = 'Dress Shirt'
)
ORDER BY c.LastName ASC;

-- 10FirstLastNamesDressShirtSortedFirstNameDescending
SELECT c.FirstName, c.LastName, i.TotalAmount
FROM Customers c
JOIN Invoice i ON c.CustomerNumber = i.CustomerNumber
WHERE i.InvoiceNumber IN (
    SELECT InvoiceNumber
    FROM Invoice_Item
    WHERE Item = 'Dress Shirt'
)
ORDER BY c.FirstName DESC;

-- 11AverageTotalAmount
SELECT AVG(TotalAmount) AS AverageTotalAmount FROM Invoice;
