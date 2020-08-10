select id, "NbElevator"
from dim_customers
group by id 
order by id