{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
    )
}}

SELECT
order_id AS order_key,
order_id AS order_id,
order_timestamp AS order_timestamp
FROM {{ source('online_purchases_transactional', 'order') }}