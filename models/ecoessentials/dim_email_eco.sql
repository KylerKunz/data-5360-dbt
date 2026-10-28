{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
    )
}}

SELECT
emailid AS email_key,
emailid AS email_id,
emailname AS email_name
FROM {{ source('sales_force_email_events', 'marketing_emails') }}