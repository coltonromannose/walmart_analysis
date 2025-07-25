--models/gold/walmart_date_dim_gold.sql
{{ config(materialized='table', schema='gold') }}

select * from {{ ref('walmart_date_dim') }}