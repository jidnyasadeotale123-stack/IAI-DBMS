/* Q3.sql */

/* Q3(a) */
SELECT
    issue_category,
    ROUND(AVG(resolution_time_hours),2) AS resolution_time_hours,
    ROUND(AVG(customer_satisfaction_score),2) AS customer_satisfaction_score
FROM support_tickets
WHERE priority='High'
  AND resolution_status='Closed'
GROUP BY issue_category
HAVING COUNT(*)>5;

/* Q3(b) */
WITH cart AS (
 SELECT customer_id,COUNT(*) cart_count
 FROM interactions
 WHERE interaction_type='Add to Cart'
 GROUP BY customer_id
),
sales AS (
 SELECT customer_id,SUM(quantity*price) revenue
 FROM transactions
 GROUP BY customer_id
),
tickets AS (
 SELECT customer_id,COUNT(*) ticket_count
 FROM support_tickets
 GROUP BY customer_id
)
SELECT
 c.preferred_channel,
 COUNT(DISTINCT c.customer_id) AS total_registered_customers,
 COALESCE(SUM(cart.cart_count),0) AS total_add_to_cart,
 COALESCE(ROUND(SUM(sales.revenue),2),0) AS total_revenue,
 COALESCE(SUM(tickets.ticket_count),0) AS total_support_tickets
FROM customers c
LEFT JOIN cart ON c.customer_id=cart.customer_id
LEFT JOIN sales ON c.customer_id=sales.customer_id
LEFT JOIN tickets ON c.customer_id=tickets.customer_id
GROUP BY c.preferred_channel
ORDER BY total_revenue DESC;
