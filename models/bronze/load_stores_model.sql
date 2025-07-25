{{ config(
    materialized = 'view',
    schema = 'BRONZE',
    alias = 'DUMMY_LOAD_STORE',
    pre_hook = load_stores()
) }}


SELECT 1 AS dummy_col
