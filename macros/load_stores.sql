{% macro load_stores() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.stores
FROM (
    SELECT
        $1 AS Store,
        $2 AS Type,
        $3 AS Size
    FROM @MY_S3_STAGE/stores.csv
)
FILE_FORMAT = MY_CSV_FORMAT
PURGE = {{ var('purge_status') }};
{% endmacro %}
