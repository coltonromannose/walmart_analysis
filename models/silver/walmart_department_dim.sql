-- models/silver/walmart_department_dim.sql
{{ config(materialized='table', schema='silver') }}

WITH dept_raw AS (
    SELECT *
    FROM {{ source('source', 'WORK_DEPARTMENTS_COPY') }}
),
date_dim AS (
    SELECT store_date, Date_id
    FROM {{ ref('walmart_date_dim') }}
)

SELECT
    d.Date_id,
    r.STORE,
    r.DEPT,
    r.DATE,
    r.WEEKLY_SALES,
    r.ISHOLIDAY,
    r.INSERT_DTS,
    r.UPDATE_DTS,
    r.SOURCE_FILE_NAME,
    r.SOURCE_FILE_ROW_NUMBER
FROM dept_raw r
JOIN date_dim d
  ON r.DATE = d.store_date
