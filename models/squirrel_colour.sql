select 	
Unique_Squirrel_ID,
Primary_Fur_Color,
Highlight_Fur_Color,
Combination_of_Primary_and_Highlight_Color
from {{ ref('squirrel_all')}}