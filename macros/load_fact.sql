{% macro load_fact() %}
COPY INTO {{ var('rawhist_db') }}.{{ var('wrk_schema') }}.WORK_FACTS_COPY
FROM @{{ var('stage_name') }}/fact.csv
FILE_FORMAT = (FORMAT_NAME = {{ var('file_format_csv') }})
PURGE = {{ var('purge_status') }}
FORCE = TRUE;
{% endmacro %}