Clients: company, contact, email, phone
Client by product: ... Rimage vs Pri should be simpler
Clients by dollars DESC
Products purchased dollars DESC



/*
	SKU by total profit
*/
SELECT
	l.ITEM AS 'SKU',
	SUM(l.QUANTO) AS 'Quantity',
	SUM(l.IT_UNCOST) AS 'Cost',
	SUM(l.IT_UNLIST) AS 'List',
	SUM(l.QUANTO * l.IT_UNCOST) AS 'Total Cost',
	SUM(l.QUANTO * l.IT_UNLIST) AS 'Total List',
	SUM(l.QUANTO * (l.IT_UNLIST-l.IT_UNCOST)) AS 'Total Profit'
FROM
	[MailOrderManager].[dbo].[ITEMS] l
GROUP BY
	l.ITEM
ORDER BY
	SUM(l.QUANTO * (l.IT_UNLIST-l.IT_UNCOST)) DESC

/*
	Clients by dollars
*/
SELECT
	s.CUSTNUM AS 'Customer',
	c.COMPANY AS 'Company',
	c.FIRSTNAME AS 'First Name',
	c.LASTNAME AS 'Last Name',
	COUNT(s.ORDERNO) AS 'Total Orders',
	SUM(s.ORD_TOTAL) AS 'Total Spent'
FROM
	[MailOrderManager].[dbo].[CMS] s JOIN
	[MailOrderManager].[dbo].[CUST] c ON s.CUSTNUM = c.CUSTNUM
GROUP BY
	s.CUSTNUM, c.COMPANY, c.FIRSTNAME, c.LASTNAME
ORDER BY
	SUM(s.ORD_TOTAL) DESC
	
/*
	Clients by product - RIM
*/
SELECT
	s.CUSTNUM AS 'Customer',
	c.COMPANY AS 'Company',
	c.FIRSTNAME AS 'First Name',
	c.LASTNAME AS 'Last Name',
	COUNT(s.ORDERNO) AS 'Total Orders',
	SUM(s.ORD_TOTAL) AS 'Total Spent'
FROM
	[MailOrderManager].[dbo].[ITEMS] i JOIN
	[MailOrderManager].[dbo].[CMS] s ON i.ORDERNO = s.ORDERNO JOIN
	[MailOrderManager].[dbo].[CUST] c ON s.CUSTNUM = c.CUSTNUM
WHERE
	i.ITEM LIKE 'RIM-%'
GROUP BY
	s.CUSTNUM, c.COMPANY, c.FIRSTNAME, c.LASTNAME
ORDER BY
	SUM(s.ORD_TOTAL) DESC
	
/*
	Clients by product - PRI
*/
SELECT
	s.CUSTNUM AS 'Customer',
	c.COMPANY AS 'Company',
	c.FIRSTNAME AS 'First Name',
	c.LASTNAME AS 'Last Name',
	COUNT(s.ORDERNO) AS 'Total Orders',
	SUM(s.ORD_TOTAL) AS 'Total Spent'
FROM
	[MailOrderManager].[dbo].[ITEMS] i JOIN
	[MailOrderManager].[dbo].[CMS] s ON i.ORDERNO = s.ORDERNO JOIN
	[MailOrderManager].[dbo].[CUST] c ON s.CUSTNUM = c.CUSTNUM
WHERE
	i.ITEM LIKE 'PRI-%'
GROUP BY
	s.CUSTNUM, c.COMPANY, c.FIRSTNAME, c.LASTNAME
ORDER BY
	SUM(s.ORD_TOTAL) DESC
	
/*
	Clients by dollars - 2013
*/
SELECT
	s.CUSTNUM AS 'Customer',
	c.COMPANY AS 'Company',
	c.FIRSTNAME AS 'First Name',
	c.LASTNAME AS 'Last Name',
	COUNT(s.ORDERNO) AS 'Total Orders',
	SUM(s.ORD_TOTAL) AS 'Total Spent'
FROM
	[MailOrderManager].[dbo].[CMS] s JOIN
	[MailOrderManager].[dbo].[CUST] c ON s.CUSTNUM = c.CUSTNUM
WHERE
	YEAR(s.ORD_DATE) = 2013
GROUP BY
	s.CUSTNUM, c.COMPANY, c.FIRSTNAME, c.LASTNAME
ORDER BY
	SUM(s.ORD_TOTAL) DESC