
{{ config(
    materialized = 'table',
    schema = 'silver'
) }}

WITH Walmart_fact_table AS (
    SELECT
        d.Date_id,
        fr.store AS Store_id,
        de.dept AS Dept_id,
        st.store_size,
        de.weekly_sales,
        fr.fuel_price,
        fr.temperature,
        fr.unemployment,
        fr.cpi,
        fr.markdown1,
        fr.markdown2,
        fr.markdown3,
        fr.markdown4,
        fr.markdown5,
        CURRENT_TIMESTAMP() AS insert_date,
        CURRENT_TIMESTAMP() AS update_date
    FROM WALMARTDB.SILVER.WALMART_FACT_RAW fr
    JOIN WALMARTDB.SILVER.WALMART_DEPARTMENT_DIM de
      ON fr.date = de.date
     AND fr.store = de.store
    JOIN WALMARTDB.SILVER.WALMART_DATE_DIM d
      ON fr.date = d.store_date
    JOIN (
        SELECT DISTINCT store_id, store_size
        FROM WALMARTDB.SILVER.WALMART_STORE_DIM
    ) st
      ON fr.store = st.store_id
)

SELECT * FROM Walmart_fact_table
