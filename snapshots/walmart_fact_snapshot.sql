{% snapshot walmart_fact_snapshot %}
{{
  config(
    target_database='WALMARTDB',
    target_schema='gold',
    unique_key='store_id || dept_id || date_id',
    strategy='check',
    check_cols=[
      'store_size',
      'weekly_sales',
      'fuel_price',
      'temperature',
      'unemployment',
      'markdown1',
      'markdown2',
      'markdown3',
      'markdown4',
      'markdown5'
    ]
  )
}}

select * from {{ ref('walmart_fact') }}

{% endsnapshot %}
