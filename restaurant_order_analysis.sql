				
									-- 	RESTAURANT ORDER ANALYSIS --
                                
                             -- EXPLORING MENU_ITEMS TABLE --   

/* 
View the menu_items table and write a query to find the number of items on the menu 
*/
select * from menu_items;
select count(item_name) from menu_items;

/* 
What are the least and most expensive items on menu
*/
select item_name,price as least_expensive from menu_items
order by price asc
limit 1;

select item_name, price as most_expensive from menu_items
order by price desc
limit 1;


/*
How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
*/
select count(menu_item_id) as no_of_Italian_Dishes from menu_items
where category = 'Italian';

select * from menu_items
where category = 'Italian'
order by price asc
limit 1;

select * from menu_items
where category = 'Italian'
order by price desc
limit 1;

/* 
How many dishes are in each category? What is the average dish price within each category?
*/
select category, count(menu_item_id) as No_of_Dishes, avg(price) as Average_Price from menu_items
group by category;


						-- EXPLORING ORDER_DETAILS TABLE --
                        
/* 
View the order_details table. What is the date range of the table?
*/
select * from order_details;

select min(order_date) as starting_date,max(order_date) as ending_date from order_details;

/*
How many orders were made within this date range? How many items were ordered within this date range?
*/
select count(distinct order_id) as orders_taken from order_details;

select count(order_details_id) as items_ordered from order_details;


/* 
Which Order has Most Number of Items
*/

select order_id, count(order_details_id) as item_sales from order_details
group by order_id
order by count(order_details_id) desc;

/*
How many orders had more than 12 items?
*/
select count(*) as orders from
(select order_id,count(order_details_id) as orders from order_details
group by order_id
having count(order_details_id) > 12) as num_orders;

/*
Combine the menu_items and order_details tables into a single table
*/

SELECT * FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id = order_details.item_id
UNION
SELECT * FROM menu_items
RIGHT JOIN order_details ON menu_items.menu_item_id = order_details.item_id;


/*
What were the least and most ordered items? What categories were they in?
*/

select menu_items.item_name,count(order_details.item_id) as ordered_times,menu_items.category from menu_items
inner join order_details
	on menu_items.menu_item_id = order_details.item_id
group by menu_items.item_name, menu_items.category
order by ordered_times desc
limit 1;

select menu_items.item_name,count(order_details.item_id) as ordered_times, menu_items.category from menu_items
inner join order_details
	on menu_items.menu_item_id = order_details.item_id
group by menu_items.item_name, menu_items.category
order by ordered_times asc
limit 1;


/*
What were the top 5 orders that spent the most money?
*/

select order_id,sum(price) as spent_money
from menu_items
inner join order_details
	on menu_items.menu_item_id = order_details.item_id
group by order_id
order by spent_money desc
limit 5;

/*
View the details of the highest spend order. Which specific items were purchased?
*/
select menu_items.item_name,count(order_details.item_id) as ordered_times,menu_items.category from menu_items
inner join order_details
	on menu_items.menu_item_id = order_details.item_id
group by menu_items.item_name, menu_items.category
order by ordered_times desc;



