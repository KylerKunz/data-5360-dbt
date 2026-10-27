{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.certification_name,
    c.certification_cost,
    e.employee_key,
    d.date_key,
from {{ ref('stg_employee_certification') }} c
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employee_id = c.employee_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_day = c.certification_awarded_date