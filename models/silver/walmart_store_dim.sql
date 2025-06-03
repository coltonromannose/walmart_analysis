{{ config(
    materialized = 'table',
    schema = 'SILVER',
    alias = 'WALMART_STORE_DIM',
    transient = true
) }}

WITH Walmart_store_dim AS (
    SELECT 
        CAST(s.store AS INT) AS Store_id,
        CAST(d.dept AS INT) AS Dept_id,
        CAST(s.type AS VARCHAR) AS Store_type,
        CAST(s.size AS INT) AS Store_Size,
        CAST(s.INSERT_DTS AS TIMESTAMP) AS Insert_date,
        CAST(s.UPDATE_DTS AS TIMESTAMP) AS Update_date
    FROM WORK_STORES_COPY s
    JOIN WORK_DEPARTMENTS_COPY d USING(STORE)
)

SELECT * FROM Walmart_store_dim
