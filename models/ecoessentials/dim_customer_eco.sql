{{ config(
    materialized = 'table',
    schema = 'DW_ECOESSENTIALS'
)}}

WITH purchase AS (
    SELECT
    customer_id AS customer_key,
    customer_id,
    customer_first_name AS customer_fname,
    customer_last_name AS customer_lname,
    customer_email,
    customer_phone,
    customer_address,
    customer_city,
    customer_state,
    customer_country,
    customer_zip AS customer_zipcode
    FROM {{ source('online_purchases_transactional', 'customer') }}
),

email AS (
    SELECT distinct
    customerid,
    subscriberfirstname,
    subscriberlastname,
    subscriberemail
    FROM {{ source('sales_force_email_events', 'marketing_emails') }}
    WHERE customerid IS NOT NULL
),

final AS (
    SELECT
    p.customer_id,
    coalesce(p.customer_fname, e.subscriberfirstname) AS customer_fname,
    coalesce(p.customer_lname, e.subscriberlastname) AS customer_lname,
    coalesce(p.customer_email, e.subscriberemail) AS customer_email,
    p.customer_phone,
    p.customer_address,
    p.customer_city,
    p.customer_state,
    p.customer_country,
    p.customer_zipcode
    FROM purchase p
    LEFT JOIN email e
        ON p.customer_fname = e.subscriberfirstname
        AND p.customer_lname = e.subscriberlastname
        AND p.customer_email = e.subscriberemail
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_fname', 'customer_lname']) }} as customer_key,
    *
from final
WHERE customer_id IS NOT NULL