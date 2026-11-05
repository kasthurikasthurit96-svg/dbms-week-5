
-- WEEK 5: PAYMENT TRANSACTION MANAGEMENT SYSTEM

USE ecommerceD__B;

-- 1. Create Payment Table

CREATE TABLE Payment (
    Payment_ID VARCHAR(10) PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Payment_Date DATE,
    Payment_Mode VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Transaction_Amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_payment_order
    FOREIGN KEY (Order_ID)
    REFERENCES orders(Order_ID),

    CONSTRAINT chk_transaction_amount
    CHECK (Transaction_Amount > 0)
);

-- 2. Display Payment Table Structure

DESC Payment;

-- 3. Insert Payment Records
-- Use Order_ID values that actually exist in your Orders table.

SELECT Order_ID
FROM orders;

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Date,
 Payment_Mode, Payment_Status, Transaction_Amount)
VALUES
('P101', 4011, '2026-10-01', 'UPI', 'Success', 2500.00);

-- 4. Display All Payment Records

SELECT * FROM Payment;

-- 5. Display Successful Payments

SELECT *
FROM Payment
WHERE Payment_Status = 'Success';

-- 6. Display Failed Payments

SELECT *
FROM Payment
WHERE Payment_Status = 'Failed';

-- 7. Display Pending Payments

SELECT *
FROM Payment
WHERE Payment_Status = 'Pending';

-- 8. Count Successful and Failed Payments

SELECT
    Payment_Status,
    COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Status;

-- 9. Update Failed Payment After Retry

UPDATE Payment
SET Payment_Status = 'Success',
    Payment_Date = '2026-10-03'
WHERE Payment_ID = 'P102'
AND Payment_Status = 'Failed';

-- 10. Retrieve Payment Details for a Specific Order

SELECT *
FROM Payment
WHERE Order_ID = 5001;

-- 11. Payment Mode Analysis

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Mode;

-- 12. Find Most Preferred Payment Method

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Mode
ORDER BY Total_Transactions DESC
LIMIT 1;

-- 13. Calculate Total Successful Revenue

SELECT
    SUM(Transaction_Amount) AS Total_Revenue
FROM Payment
WHERE Payment_Status = 'Success';

-- 14. Revenue by Payment Method

SELECT
    Payment_Mode,
    SUM(Transaction_Amount) AS Total_Revenue
FROM Payment
WHERE Payment_Status = 'Success'
GROUP BY Payment_Mode;

-- 15. Calculate Average Transaction Amount

SELECT
    AVG(Transaction_Amount) AS Average_Transaction_Amount
FROM Payment
WHERE Payment_Status = 'Success';

-- 16. Customer Payment History

SELECT
    c.Customer_Name,
    o.Order_ID,
    p.Payment_ID,
    p.Payment_Mode,
    p.Transaction_Amount,
    p.Payment_Status,
    p.Payment_Date
FROM Payment p
INNER JOIN orders o
    ON p.Order_ID = o.Order_ID
INNER JOIN customer c
    ON o.Customer_ID = c.Customer_id
ORDER BY p.Payment_Date DESC;

-- 17. Display Payment Count by Status

SELECT
    Payment_Status,
    COUNT(*) AS Total_Payments
FROM Payment
GROUP BY Payment_Status
ORDER BY Total_Payments DESC;
