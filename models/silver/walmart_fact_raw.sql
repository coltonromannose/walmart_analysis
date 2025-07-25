{{ config(materialized='table', schema='silver', alias='walmart_fact_raw') }}

SELECT *
FROM {{ source('source', 'WORK_FACTS_COPY') }}