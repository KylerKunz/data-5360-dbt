
{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
)}}

SELECT
    s.subscriber_key,
    c.campaign_key,
    cust.customer_key,
    em.email_key,
    ev.event_key,
    ee.sendtimestamp,
    ee.eventtimestamp
FROM {{ source('sales_force_email_events', 'marketing_emails') }} AS ee
INNER JOIN {{ ref('dim_subscriber_eco') }} AS s ON s.subscriber_id = ee.subscriberid
INNER JOIN {{ ref('dim_email_eco') }} AS em ON em.email_id = ee.emailid
INNER JOIN {{ ref('dim_campaign_eco') }} AS c ON c.campaign_id = ee.campaignid
LEFT JOIN {{ ref('dim_customer_eco') }} AS cust
    ON NULLIF(LOWER(TRIM(CAST(cust.customer_id AS VARCHAR))), 'null')
     = NULLIF(LOWER(TRIM(CAST(ee.customerid AS VARCHAR))), 'null')
INNER JOIN {{ ref('dim_event_eco') }} AS ev ON ev.event_type = ee.eventtype
INNER JOIN {{ ref('dim_date_eco') }} AS send_date ON send_date.date_day = CAST(ee.sendtimestamp AS DATE)
INNER JOIN {{ ref('dim_date_eco') }} AS event_date ON event_date.date_day = CAST(ee.eventtimestamp AS DATE)