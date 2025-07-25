{% macro load_fact() %}
DELETE FROM {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_FACTS_COPY;

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
  FROM @{{ var('stage_name') }}/fact_updated_test.csv
)
FILE_FORMAT = {{ var('file_format_csv') }}
PURGE = TRUE
FORCE = TRUE
ON_ERROR = 'CONTINUE';
{% endmacro %}
