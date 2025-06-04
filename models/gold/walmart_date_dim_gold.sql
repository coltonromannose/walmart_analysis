{{ config(materialized='table', schema='gold') }}

select * from {{ ref('walmart_date_dim') }}
