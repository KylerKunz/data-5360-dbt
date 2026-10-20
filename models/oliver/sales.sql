
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
d.date_day,
c.first_name AS cust_f_name,
c.last_name AS cust_l_name,
s.store_name,
e.first_name AS emp_f_name,
e.last_name AS emp_l_name,
p.product_name,
f.unit_price,
f.quantity,
f.dollars_sold

FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.cust_key = c.cust_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key

