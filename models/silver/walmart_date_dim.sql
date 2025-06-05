WITH distinct_dates AS (
    SELECT DISTINCT
        DATE
    FROM WALMARTDB.BRONZE.WORK_DEPARTMENTS_COPY
),

holidays AS (
    SELECT DISTINCT
        DATE,
        MAX(CASE WHEN IsHoliday THEN TRUE ELSE FALSE END) AS IsHoliday,
        MAX(INSERT_DTS) AS Insert_date,
        MAX(UPDATE_DTS) AS Update_date
    FROM WALMARTDB.BRONZE.WORK_DEPARTMENTS_COPY
    GROUP BY DATE
)

SELECT 
    DENSE_RANK() OVER (ORDER BY d.DATE) AS Date_id,
    CAST(d.DATE AS DATE) AS Store_date,
    COALESCE(h.IsHoliday, FALSE) AS IsHoliday,
    h.Insert_date,
    h.Update_date
FROM distinct_dates d
LEFT JOIN holidays h ON d.DATE = h.DATE
