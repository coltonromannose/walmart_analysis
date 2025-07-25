-- models/gold/walmart_store_dim_gold.sql
{{ config(materialized='table', schema='gold') }}

select * from {{ ref('walmart_store_dim') }}
