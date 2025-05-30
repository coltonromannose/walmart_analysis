
{# Helps when routing models to different schemas dynamically #}

{% macro generate_schema_name(custom_schema_name, node) -%}

    {# Get default schema from profile target #}
    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is none -%}

        {# Use default if no custom schema is passed #}
        {{ default_schema }}

    {%- else -%}

        {# Use the custom schema provided #}
        {{ custom_schema_name }}

    {%- endif -%}

{%- endmacro %}
