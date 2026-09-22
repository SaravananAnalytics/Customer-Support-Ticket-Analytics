CREATE DATABASE support_ticket_rootcauseanalysis
USE support_ticket_rootcauseanalysis

SELECT * FROM dbo.support_ticket_RCA

-- Business Problems

--1. Which products generate the highest number of customer support tickets?

SELECT
	product_purchased,
	COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY product_purchased
ORDER BY COUNT(ticket_id) DESC

--2. What are the most common types of customer issues?

SELECT
	ticket_type,
	COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_type
ORDER BY COUNT(ticket_id) DESC

--3. How many tickets are Open, Pending, and Resolved?

SELECT
	ticket_status,
	COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_status
ORDER BY COUNT(ticket_id)

--4.How many tickets exist for each priority level?

SELECT
	ticket_priority,
	COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_priority
ORDER BY COUNT(ticket_id) DESC

--5. Which support channel receives the most customer tickets?

SELECT
	ticket_channel,
	COUNT(ticket_id) AS total_tickets
FROM support_ticket_RCA
GROUP BY ticket_channel
ORDER BY COUNT(ticket_id) DESC

--6. What is the average resolution time for each ticket priority?

SELECT TOP 10
	resolution,
	ROUND(AVG(resolution_hours),2) AS avg_resolution_hours
FROM support_ticket_RCA
WHERE resolution_hours IS NOT NULL
GROUP BY resolution
ORDER BY ROUND(AVG(resolution_hours),2) DESC

--7. What is the average customer satisfaction rating for each ticket type?

SELECT
	ticket_type,
	ROUND(AVG(customer_satisfaction_rating),2) AS avg_satisfaction_rating
FROM support_ticket_RCA
WHERE customer_satisfaction_rating IS NOT NULL
GROUP BY ticket_type
ORDER BY ROUND(AVG(customer_satisfaction_rating),2) DESC

--8.Which support channels have the highest and lowest average customer satisfaction ratings?

WITH channel_ratings AS(
	SELECT
		ticket_channel,
		ROUND(AVG(customer_satisfaction_rating),2) AS avg_satisfaction_rating
		FROM support_ticket_RCA
		WHERE customer_satisfaction_rating IS NOT NULL
		GROUP BY ticket_channel
)
SELECT * 
FROM channel_ratings
WHERE avg_satisfaction_rating = (SELECT MAX(avg_satisfaction_rating) FROM channel_ratings)
OR avg_satisfaction_rating = (SELECT MIN(avg_satisfaction_rating) FROM channel_ratings)

--9. Which products have the largest number of unresolved tickets?

SELECT
    product_purchased,
    COUNT(ticket_id) AS unresolved_tickets
FROM support_ticket_RCA
WHERE ticket_status IN ('Open', 'Pending')
GROUP BY product_purchased
ORDER BY unresolved_tickets DESC;

--10. Which product and ticket-type combinations have the highest number of tickets and lowest customer satisfaction?

SELECT
    product_purchased,
    ticket_type,
    COUNT(ticket_id) AS total_tickets,
    ROUND(AVG(customer_satisfaction_rating), 2) AS avg_satisfaction_rating
FROM support_ticket_RCA
GROUP BY
    product_purchased,
    ticket_type
ORDER BY
    total_tickets DESC;