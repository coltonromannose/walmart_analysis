-- models/silver/walmart_department_dim.sql
{{ config(materialized='table', schema='silver') }}

select * from {{ source('source', 'WORK_DEPARTMENTS_COPY') }}