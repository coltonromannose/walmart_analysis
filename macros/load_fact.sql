{% macro load_fact() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_FACTS_COPY
FROM @MY_S3_STAGE/fact.csv
FILE_FORMAT = (FORMAT_NAME = 'MY_CSV_FORMAT')
PURGE = FALSE;
{% endmacro %}
