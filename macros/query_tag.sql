
{#setting dynamic query_tags based on the DBT model name. That way, 
every query is traceable in Snowflake’s query history. It helps a lot for debugging,
 performance tuning, and even cost attribution per model#}


{% macro set_query_tag() -%}

  {# Set the query tag to the current model's name (used for tracking/auditing in Snowflake) #}
  {% set new_query_tag = model.name %} {# always use model name #}

  {% if new_query_tag %}

    {# Capture the existing query tag so we can restore it later #}
    {% set original_query_tag = get_current_query_tag() %}

    {# Log the change so it's visible in DBT's logs #}
    {{ log("Setting query_tag to '" ~ new_query_tag ~ "'. Will reset to '" ~ original_query_tag ~ "' after materialization.") }}

    {# Actually apply the new query tag in the current Snowflake session #}
    {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}

    {# Return the original query tag so it can be reset later #}
    {{ return(original_query_tag)}}

  {% endif %}

  {# If no new_query_tag (unlikely), return none #}
  {{ return(none)}}

{% endmacro %}
