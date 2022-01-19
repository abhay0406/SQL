select carton.CARTON_ID, min(carton.LEN*carton.HEIGHT*carton.WIDTH) as CARTON_VOL
from carton
where (carton.LEN*carton.HEIGHT*carton.WIDTH)>(select sum(product.HEIGHT*product.LEN*product.WIDTH*order_items.PRODUCT_QUANTITY) as TOTAL_VOL
from product, order_items
where order_items.ORDER_ID = 10006
AND product.PRODUCT_ID = order_items.PRODUCT_ID);

--------------------------------------------------------------------------------------------

select online_customer.CUSTOMER_ID, concat(online_customer.customer_fname," ",online_customer.customer_lname) as customer_name, order_header.ORDER_ID,
order_items.PRODUCT_QUANTITY
from online_customer
join order_header on online_customer.CUSTOMER_ID = order_header.CUSTOMER_ID
join order_items on order_header.ORDER_ID=order_items.ORDER_ID
where order_header.ORDER_STATUS = "Shipped"
group by order_header.ORDER_ID
having sum(order_items.PRODUCT_QUANTITY)>10;

--------------------------------------------------------------------------------------------------

select order_header.ORDER_ID, online_customer.CUSTOMER_ID, concat(online_customer.customer_fname," ",online_customer.customer_lname) as customer_name,
sum(order_items.PRODUCT_QUANTITY) as totalquantity
from online_customer
join order_header on online_customer.CUSTOMER_ID=order_header.CUSTOMER_ID
join order_items on order_header.ORDER_ID=order_items.ORDER_ID
where order_header.ORDER_STATUS = "Shipped"
and order_items.ORDER_ID>10060
group by order_items.ORDER_ID;

----------------------------------------------------------------------------------------------------------------

select product.PRODUCT_DESC, sum(order_items.PRODUCT_QUANTITY) as TOTAL_QUANTITY, sum(order_items.PRODUCT_QUANTITY*product.PRODUCT_PRICE) as TOTAL_VALUE
from product
join order_items on product.PRODUCT_ID=order_items.PRODUCT_ID
join order_header on order_items.ORDER_ID=order_header.ORDER_ID
join online_customer on order_header.CUSTOMER_ID=online_customer.CUSTOMER_ID
join address on online_customer.ADDRESS_ID=address.ADDRESS_ID
where address.COUNTRY not in ("India" ,"USA")
group by product.PRODUCT_CLASS_CODE
order by sum(order_items.PRODUCT_QUANTITY) desc
limit 1;
