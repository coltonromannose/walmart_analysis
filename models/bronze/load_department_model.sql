{{ config(
    materialized = 'view',
    schema = 'BRONZE',
    alias = 'DUMMY_LOAD_DEPARTMENT',
    pre_hook = load_department()
) }}


SELECT 1 AS dummy_col
