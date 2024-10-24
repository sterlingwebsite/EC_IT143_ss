--step 1

select *
from sales.CreditCard

--step 2

--this finds columns that are not indexed
SELECT 
    t.name AS TableName,
    c.name AS ColumnName
FROM 
    sys.tables t
JOIN 
    sys.columns c ON t.object_id = c.object_id
LEFT JOIN 
    sys.index_columns ic ON c.object_id = ic.object_id AND c.column_id = ic.column_id
LEFT JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE 
    c.system_type_id IN (167, 175, 231, 239)  -- Types: VARCHAR, CHAR, NVARCHAR, NCHAR
    AND i.object_id IS NULL
ORDER BY 
    t.name, c.name;

--here is a column I choose to index
select *
from sales.CreditCard
where CardType = 'SuperiorCard';

--step 3 execution plan

--step 4 review the execution plan

--step 5 subtree cost and missing index recommendations

--step 6 Opposite click on the missing index recommendation and select missing index details

--step 7 name the index and execute the script

--step 8 Re-run the query to see if performance improves in terms of runtime and estimated subtree cost

