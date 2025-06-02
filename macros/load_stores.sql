{% macro load_stores() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_STORES_COPY
FROM (
    SELECT
        $1 AS Store,
        $2 AS Type,
        $3 AS Size,
        CURRENT_TIMESTAMP() AS INSERT_DTS,
        CURRENT_TIMESTAMP() AS UPDATE_DTS,
        metadata$filename AS SOURCE_FILE_NAME,
        metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
    FROM @MY_S3_STAGE/stores.csv
)
FILE_FORMAT = MY_CSV_FORMAT
PURGE = {{ var('purge_status') }};
{% endmacro %}
