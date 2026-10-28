{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
    )
}}

SELECT
subscriberid AS subscriber_key,
subscriberid AS subscriber_id,
subscriberemail AS subscriber_email,
subscriberfirstname AS subscriber_fname,
subscriberlastname AS subscriber_lname
FROM {{ source('sales_force_email_events', 'marketing_emails') }}