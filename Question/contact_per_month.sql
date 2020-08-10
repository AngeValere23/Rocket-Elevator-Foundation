select count(id), TO_CHAR("CreationDate", 'Month')
from fact_contacts
group by TO_CHAR("CreationDate", 'Month')
order by TO_CHAR("CreationDate", 'Month')