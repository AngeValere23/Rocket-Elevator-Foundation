select count(id), TO_CHAR("CreationDate", 'Month')
from fact_quotes
group by TO_CHAR("CreationDate", 'Month')
order by TO_CHAR("CreationDate", 'Month')