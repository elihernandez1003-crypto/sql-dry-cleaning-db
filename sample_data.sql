-- Customers
INSERT INTO Customers (FirstName, LastName, Phone, Email) VALUES
('Nikki', 'Kaccaton', '723-543-1233', 'nikki.kaccaton@example.com'),
('Brenda', 'Catnazaro', '723-543-2344', 'brenda.catnazaro@example.com');

-- Invoices
INSERT INTO Invoices (CustomerID, DateIn, DateOut, TotalAmount) VALUES
(1, '2025-08-01', '2025-08-03', 158.50),
(2, '2025-08-02', '2025-08-04', 25.00);

-- Invoice Items
INSERT INTO InvoiceItems (InvoiceID, ItemName, Quantity, UnitPrice) VALUES
(1, 'Blouse', 2, 3.50),
(1, 'Dress Shirt', 5, 2.50),
(2, 'Suit-Mens', 1, 9.00);