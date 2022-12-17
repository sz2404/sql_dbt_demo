select *
from {{ source('SQL_DBT_demo', 'Squirrel_2018_census')}}