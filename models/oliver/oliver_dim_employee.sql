{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
employee_id as employee_key,
employee_id,
position,
hire_date,
email,
last_name,
phone_number,
first_name
FROM {{ source('oliver_landing', 'employee') }}