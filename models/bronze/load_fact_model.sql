{{ config(
    materialized = 'view',
    schema = 'BRONZE',
    alias = 'DUMMY_LOAD_FACT',
    pre_hook = load_fact()
) }}


SELECT 1 AS dummy_col
