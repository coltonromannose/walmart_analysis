{{ config(
    materialized = 'table',
    schema = 'SILVER',
    alias = 'WALMART_DATE_DIM',
    transient = true
) }}

WITH Walmart_date_dim AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY DATE) AS Date_id,
        CAST(date AS DATE) AS Store_date,
        CAST(IsHoliday AS BOOLEAN) AS Is_holiday,
        CAST(INSERT_DTS AS TIMESTAMP) AS Insert_date,
        CAST(UPDATE_DTS AS TIMESTAMP) AS Update_date
    FROM WALMARTDB.BRONZE.WORK_DEPARTMENTS_COPY
)

SELECT * FROM Walmart_date_dim
