{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
    )
}}

SELECT
campaign_id AS campaign_key,
campaign_id,
campaign_name,
campaign_discount
FROM {{ source('online_purchases_transactional', 'promotional_campaign') }}