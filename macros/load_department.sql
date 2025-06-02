{% macro load_departments() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.departments
FROM (
    SELECT
        $1 AS Store,
        $2 AS Dept,
        $3 AS Date,
        $4 AS Weekly_Sales,
        $5 AS IsHoliday
    FROM @MY_S3_STAGE/departments/
)
FILE_FORMAT = MY_CSV_FORMAT
PURGE = {{ var('purge_status') }};
{% endmacro %}