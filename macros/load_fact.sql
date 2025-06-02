{% macro load_fact() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.fact
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
        $12 AS IsHoliday
    FROM @MY_S3_STAGE/fact.csv
)
FILE_FORMAT = MY_CSV_FORMAT
PURGE = {{ var('purge_status') }};
{% endmacro %}
