{{ config(
    materialized = 'table',
    schema = 'SILVER',
    alias = 'WALMART_STORE_DIM',
    transient = true
) }}

WITH Walmart_store_dim AS (
    SELECT 
        CAST(s.store AS INT) AS store_id,
        CAST(d.dept AS INT) AS dept_id,
        CAST(s.type AS VARCHAR) AS store_type,
        CAST(s.size AS INT) AS store_size,
        CAST(s.INSERT_DTS AS TIMESTAMP) AS insert_date,
        CAST(s.UPDATE_DTS AS TIMESTAMP) AS update_date
    FROM {{ source('source', 'WORK_STORES_COPY') }} s
    JOIN {{ source('source', 'WORK_DEPARTMENTS_COPY') }} d 
      ON s.store = d.store
)

SELECT * FROM Walmart_store_dim

