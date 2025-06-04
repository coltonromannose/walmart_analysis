{{ config(
    materialized = 'table',
    schema = 'SILVER',
    alias = 'WALMART_DATE_DIM',
    transient = true
) }}

WITH distinct_dates AS (
    SELECT 
        DATE,
        MAX(CASE WHEN IsHoliday THEN TRUE ELSE FALSE END) AS IsHoliday,
        MAX(INSERT_DTS) AS Insert_date,
        MAX(UPDATE_DTS) AS Update_date
    FROM WALMARTDB.BRONZE.WORK_DEPARTMENTS_COPY
    GROUP BY DATE
)

SELECT 
    DENSE_RANK() OVER (ORDER BY DATE) AS Date_id,
    CAST(DATE AS DATE) AS Store_date,
    IsHoliday,
    Insert_date,
    Update_date
FROM distinct_dates
