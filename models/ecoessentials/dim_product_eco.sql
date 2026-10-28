{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
    )
}}

SELECT
product_id as product_key,
product_id,
product_type,
product_name,
price
FROM {{ source('online_purchases_transactional', 'product') }}