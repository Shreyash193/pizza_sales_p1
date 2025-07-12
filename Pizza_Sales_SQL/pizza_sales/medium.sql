-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT sum(order_details.quantity) as quantity ,pizza_types.category
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.category order by  quantity desc;

-- Determine the distribution of orders by hour of the day.

SELECT hour(order_time) as hour,count(order_id) as count from orders
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.


SELECT round(avg(quantity),0) from
(SELECT orders.order_date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date ) as order_qunatity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, sum(order_details.quantity * pizzas.price) as rev 
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name order by rev desc limit 5 ;
