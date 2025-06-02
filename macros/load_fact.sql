{% macro load_fact() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_FACTS_COPY
FROM (
    SELECT
        $1 AS Store,
        $2 AS Date,
        $3 AS Temperature,
        $4 AS Fuel_Price,
        $5 AS MarkDown1,
        $6 AS MarkDown2,
        $7 AS MarkDown3,
        $8 AS MarkDown4,
        $9 AS MarkDown5,
        $10 AS CPI,
        $11 AS Unemployment,
        $12 AS IsHoliday,
        CURRENT_TIMESTAMP() AS INSERT_DTS,
        CURRENT_TIMESTAMP() AS UPDATE_DTS,
        metadata$filename AS SOURCE_FILE_NAME,
        metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
    FROM @MY_S3_STAGE/fact.csv
)
FILE_FORMAT = MY_CSV_FORMAT
ON_ERROR = 'SKIP_FILE'
PURGE = {{ var('purge_status') }};
{% endmacro %}
