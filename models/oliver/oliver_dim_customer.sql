{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
customer_id as cust_key,
customer_id,
state,
email,
last_name,
phone_number,
first_name
FROM {{ source('oliver_landing', 'customer') }}