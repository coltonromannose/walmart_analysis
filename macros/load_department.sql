{% macro load_department() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_DEPARTMENTS_COPY
FROM (
    SELECT
        $1 AS Store,
        $2 AS Dept,
        $3 AS Date,
        $4 AS Weekly_Sales,
        $5 AS IsHoliday,
        CURRENT_TIMESTAMP() AS INSERT_DTS,
        CURRENT_TIMESTAMP() AS UPDATE_DTS,
        metadata$filename AS SOURCE_FILE_NAME,
        metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
    FROM @MY_S3_STAGE/department.csv
)
FILE_FORMAT = MY_CSV_FORMAT
PURGE = {{ var('purge_status') }};
{% endmacro %}
