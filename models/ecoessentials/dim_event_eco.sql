
{{
    config(
        materialized = 'table',
        schema = 'DW_ECOESSENTIALS'
    )
}}

WITH distinct_events AS (
    SELECT DISTINCT
        eventtype AS event_type
    FROM {{ source('sales_force_email_events', 'marketing_emails') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY event_type) AS event_key,
    event_type
FROM distinct_events
