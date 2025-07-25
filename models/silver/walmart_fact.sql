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
    FROM {{ ref('walmart_fact_raw') }} fr
    JOIN {{ ref('walmart_date_dim') }} d
      ON fr.date = d.store_date
    JOIN {{ ref('walmart_department_dim') }} de
      ON d.Date_id = de.Date_id
     AND fr.store = de.store
    JOIN (
        SELECT DISTINCT store_id, store_size
        FROM {{ ref('walmart_store_dim') }}
    ) st
      ON fr.store = st.store_id
)

SELECT * FROM Walmart_fact_table
