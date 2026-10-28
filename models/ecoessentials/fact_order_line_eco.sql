{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
)}}

SELECT
    p.product_key,
    o.order_key,
    c.campaign_key,
    cust.customer_key,
    ol.quantity,
    ol.discount
FROM {{ source('online_purchases_transactional', 'order_line') }} AS ol
INNER JOIN {{ source('online_purchases_transactional', 'order') }} AS ord ON ord.order_id = ol.order_id
INNER JOIN {{ ref('dim_product_eco') }} AS p ON p.product_id = ol.product_id
INNER JOIN {{ ref('dim_order_eco') }} AS o ON o.order_id = ol.order_id
INNER JOIN {{ ref('dim_campaign_eco') }} AS c ON c.campaign_id = ol.campaign_id
INNER JOIN {{ ref('dim_customer_eco') }} AS cust ON cust.customer_id = ord.customer_id