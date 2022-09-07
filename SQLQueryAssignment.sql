use adventureworks2019;

select * from production.product

--ques 1. Write a SELECT statement that lists the customer ID numbers and sales orderID numbers from the Sales.SalesOrderHeader table.
select * from sales.salesorderheader
select salesorderid, customerid from sales.salesorderheader

--ques 2. Write a query that displays all the rows from the Person.Person table where the rows were modified after December 29, 2005. Display the business entity ID number, the name columns, and the modified date.
select * from person.person
select businessentityid, firstname, middlename, lastname, modifieddate 
from person.person 
where modifieddate > '2000-12-29'

--ques 3. Rewrite the last query so that the rows that were not modified on November08,2013, are displayed.
select businessentityid, firstname, middlename, lastname, modifieddate 
from person.person 
where not modifieddate = '2000-12-29'

--ques 4. . Rewrite the query from question 5 so that it displays the rows modified during December 2009.
select businessentityid, firstname, middlename, lastname, modifieddate 
from person.person 
where modifieddate between '2009-12-29' and '2010-12-29'

--ques 5. Write a query displaying the order ID, order date, and total due from the Sales.SalesOrderHeader table. Retrieve only those rows where the order was placed during the month of September 2012 and the total due exceeded $1,000.
select * from sales.salesorderheader
select salesorderid, orderdate, totaldue from sales.salesorderheader
where orderdate between '2012-09-1' and '2012-09-30' and totaldue > 1000

--ques 6. Write a query displaying the sales orders where the total due exceeds $1,000. Retrieve only those rows where the salesperson ID is 279 or the territory ID is 6.
select salesorderid from sales.salesorderheader
where totaldue > 1000 
and salespersonid  = 279 or territoryid = 6

--ques 7. Change the query in question 3 so that territory 4 is included with territory 6
select salesorderid, salespersonid, territoryid from sales.salesorderheader
where totaldue > 1000 
and salespersonid  = 279 and territoryid in(4,6)

--ques 8. Write a query that displays the product ID and name for each product from the Production.Product table with the name starting with Chain
select * from production.product
select productid, name from production.product 
where name like 'chain%'

--ques 9. Write a query like the one in question 1 that displays the products with helmet in the name.
select productid, name from production.product 
where name like '%helmet%'

--ques 10. Change the last query so that the products without helmet in the name are displayed.
select productid, name from production.product 
where name not like '%helmet%'

--ques 11. Write a query that displays the business entity ID number, first name, middle name, and last name from the Person.Person table for only those rows that have E or B stored in the middle name column
select * from person.person
select businessentityid, firstname, middlename, lastname from person.person
where middlename like '%e%' or middlename like '%b%' order by businessentityid;

--ques 12. Explain the difference between the following two queries: SELECT FirstName FROM Person.Person WHERE LastName LIKE 'Ja%es'; SELECT FirstName FROM Person.Person WHERE LastName LIKE 'Ja_es';
--ja%es :will return rows with any number of characters replacing %.
--ja_es :only one character can replace the underscore.

--ques 13. Write a query that displays the first 10 characters of the AddressLine1 column in the Person.Address table.
select * from person.address
select AddressID, addressline1 from person.address order by AddressID
select AddressID, substring(AddressLine1, 1, 10) FROM person.address order by AddressID

--ques 14. Write a query that displays characters 10 to 15 of the AddressLine1 column in the Person.Address table.
select addressid, substring(AddressLine1, 10, 6) FROM person.address order by addressid

--ques 15. Write a query that displays only the date, not the time, for the order date and ship date in the Sales.SalesOrderHeader table
select * from sales.salesorderheader
select cast(orderdate as date), cast(shipdate as date) from sales.salesorderheader

--ques 16. Write a query that displays the year of each order date and the numeric month of each order date in separate columns in the results. Include the SalesOrderID and OrderDate columns.
select year(orderdate) as year_of_order, month(orderdate) as month_of_order, salesorderid, orderdate  from sales.salesorderheader

--ques 17. Change the query written in the above question to display the month name instead.
select datename(month, orderdate) from sales.salesorderheader

--ques 18. The HumanResources.Employee table does not contain the employee names. Join that table to the Person.Person table on the BusinessEntityID column. Display the job title, birth date, first name, and last name
select * from humanresources.employee
select * from person.person
select humanresources.employee.jobtitle, humanresources.employee.birthdate, person.person.firstname, person.person.middlename, person.person.lastname
from humanresources.employee
inner join person.person on humanresources.employee.businessentityid = person.person.businessentityid

--ques 19. The customer names also appear in the Person.Person table. Join the Sales.Customer table to the Person.Person table. The BusinessEntityID column in the Person.Person table matches the PersonID column in the Sales.Customer table. Display the CustomerID, StoreID, and TerritoryID columns along with the name columns.
select * from sales.customer
select sales.customer.customerid, sales.customer.storeid, sales.customer.territoryid, person.person.firstname, person.person.middlename, person.person.lastname
from person.person
inner join sales.customer on person.person.businessentityid = sales.customer.personid

--ques 20. Extend the query written in above question to include the Sales.SalesOrderHeader table. Display the SalesOrderID column along with the columns already specified. The Sales.SalesOrderHeader table joins the Sales.Customer table on CustomerID.
select * from sales.salesorderheader
select sales.customer.customerid, sales.customer.storeid, sales.customer.territoryid, person.person.firstname, person.person.middlename, person.person.lastname, sales.salesorderheader.salesorderid
from person.person
inner join sales.customer on person.person.businessentityid = sales.customer.personid
inner join sales.salesorderheader on sales.customer.customerid = sales.salesorderheader.customerid

--ques 21. Write a query that joins the Sales.SalesOrderHeader table to the Sales. SalesPerson table. Join the BusinessEntityID column from the Sales.SalesPerson table to the SalesPersonID column in the Sales.SalesOrderHeader table. Display the SalesOrderID along with the SalesQuota and Bonus.
select * from sales.salesorderheader
select * from sales.salesperson
select sales.salesorderheader.salesorderid, sales.salesperson.salesquota, sales.salesperson.bonus
from sales.salesperson
inner join sales.salesorderheader on sales.salesperson.businessentityid = sales.salesorderheader.salespersonid

--ques 22. Add the name columns to the query written in question above by joining on the Person.Person table. See whether you can figure out which columns will be used to write the join.
select sales.salesorderheader.salesorderid, sales.salesperson.salesquota, sales.salesperson.bonus, person.person.firstname, person.person.middlename, person.person.lastname
from sales.salesperson
inner join sales.salesorderheader on sales.salesperson.businessentityid = sales.salesorderheader.salespersonid
inner join person.person on sales.salesperson.businessentityid = person.person.businessentityid

--ques 23. The catalog description for each product is stored in the Production.ProductModel table. Display the columns that describe the product from the Production.Product table, such as the color and size along with the catalog description for each product.
select * from production.productmodel
select * from production.product
select production.product.color, production.product.size, production.productmodel.catalogdescription
from production.product
inner join production.productmodel on production.productmodel.name = production.product.name

--ques 24. Write a query that displays the names of the customers along with the product names that they have purchased. Hint: Five tables will be required to write this query
--names of customers and product name
select person.person.firstname, person.person.middlename, person.person.lastname, production.product.name
from person.person
inner join sales.customer on person.person.businessentityid = sales.customer.personid
inner join sales.salesorderheader on sales.customer.customerid = sales.salesorderheader.customerid
inner join sales.salesorderdetail on sales.salesorderheader.salesorderid = sales.salesorderdetail.salesorderid
inner join production.product on sales.salesorderdetail.productid = production.product.productid

--tables...
select * from person.person --names, businessentityid
select * from production.product --names_prod, productid
select * from sales.salesorderdetail --salesorderid, productid
select * from sales.salesorderheader --salesorderid, customerid
select * from sales.customer --customerid

-- ques 25. Write a query that displays all the products along with the SalesOrderID even if an order has never been placed for that product. Join to the Sales.SalesOrderDetail table using the ProductID column.
select * from sales.salesorderdetail
select sales.salesorderdetail.salesorderid, production.product.name
from production.product
left join sales.salesorderdetail on production.product.productid = sales.salesorderdetail.productid

--ques 26. Change the query written in question above so that only products that have not been ordered show up in the query
select sales.salesorderdetail.salesorderid, production.product.name
from production.product
right join sales.salesorderdetail on production.product.productid = sales.salesorderdetail.productid

--ques 27. Write a query that returns all the rows from the Sales.SalesPerson table joined to the Sales.SalesOrderHeader table along with the SalesOrderID column even if no orders match. Include the SalesPersonID and SalesYTD columns in the results.
select * from sales.salesperson
select * from sales.salesorderheader
select sales.salesorderheader.salespersonid, sales.salesperson.salesytd, sales.salesorderheader.salesorderid
from sales.salesorderheader 
left join sales.salesperson on sales.salesperson.territoryid = sales.salesorderheader.territoryid 

--ques 28. Change the query written in the above question so that the salesperson’s name also displays from the Person.Person table
select sales.salesorderheader.salespersonid, sales.salesperson.salesytd, sales.salesorderheader.salesorderid, person.person.firstname, person.person.middlename, person.person.lastname
from sales.salesorderheader 
left join sales.salesperson on sales.salesperson.territoryid = sales.salesorderheader.territoryid 
left join person.person on sales.salesperson.businessentityid = person.person.businessentityid 

--ques 29. Using a subquery, display the product names and product ID numbers from the Production.Product table that have been ordered.
select * from production.product
select * from sales.salesorderdetail
select productid, name from production.product where productid in (select productid from sales.salesorderdetail) order by productid

--ques 30. Change the query written in question above to display the products that have not been ordered.
select productid, name from production.product where productid not in (select productid from sales.salesorderdetail) order by productid

--ques 31. Write a query using a subquery that returns the rows from the Production.ProductColor table that are not being used in the Production.Product table.
select * from production.productcolor --wrong
select * from production.product

--ques 32. Write a UNION query that combines the ModifiedDate from Person.Person and the HireDate from HumanResources.Employee.
select modifieddate from person.person
union all
select hiredate from humanresources.employee  


