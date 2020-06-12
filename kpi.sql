--------------- 1. Quantity produced in total (per machine)--------------------------------

select 
m.id as machine,
sum(po.quantity_produced) as total_per_machine
from production_orders po 
left join machines m 
on m.id = po.machine_id
group by m.id 
order by sum(po.quantity_produced) desc 

---------------------------------------------------------------------------------------------

----------------2. Cost per machine x number of production orders per machine----------------
select 
m.id as machine, 
sum(po.id) as production_orders
from machines m 
right join production_orders po 
on po.machine_id = m.id
group by m.id
order by sum(po.id) desc

----------------------------------------------------------------------------------------------

select * from production_orders 
full join machines on machines.id = production_orders.machine_id


select * from machine_types

select * from production_job_definitions

------------ 4. Average production time per machine and machine type/ difference--------------

select 
mt.name as machine_name, 
avg(po.time_ended - po.time_started) as avg_production_time
from production_orders po 
full join machines m on m.id = po.machine_id
full join machine_types mt on mt.id = m.machine_type_id
group by mt.name 
order by avg(po.time_ended - po.time_started) desc 
------------------------------------------------------------------------------------------------

------------ 10. Manufacturing cost per unit----------------------------------------------------
select
o.id, 
sum(ot.quantity * ot.price) as cost 
from orders o 
full join order_items ot on ot.order_id = o.id
group by o.id
------------------------------------------------------------------------------------------------

------------8. Time from order to shipment ------------------------------------------------------
select * from shippings

select * from orders

select * from shipping_items

select 
si.timestamp - o.timestamp
from shipping_items si 
full join shippings s on s.id = si.shipping_id
full join orders o on o.id = s.order_id

select 
(o.timestamp - sh.timestamp) as time_from_o_to_sh
from shippings sh 
full join orders o on o.id = sh.order_id
-----------------------------------------------------------------------------------------------
