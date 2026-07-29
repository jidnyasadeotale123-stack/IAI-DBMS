/* Q2.sql */

/* Q2(a) */
SELECT
    full_name,
    email,
    city,
    preferred_channel
FROM customers
WHERE state IN ('California','Texas')
  AND registration_date > '2023-01-01'
ORDER BY full_name ASC;

/* Q2(b) */
SELECT
    c.customer_id,
    c.full_name,
    c.email,
    FORMAT(SUM(t.quantity * t.price),2) AS total_spent,
    COUNT(DISTINCT t.transaction_id) AS total_transactions
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
WHERE t.store_location='Online'
GROUP BY c.customer_id,c.full_name,c.email
HAVING SUM(t.quantity*t.price) > 1000
   AND COUNT(DISTINCT t.transaction_id) >= 3
ORDER BY SUM(t.quantity*t.price) DESC;
