with orders as (
    select * from {{ ref('stg_orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
)

SELECT
    O.order_id, 
    O.customer_id, 
    SUM(P.AMOUNT) AS TOTAL_AMOUNT, 
    SUM(CASE WHEN P.STATUS = 'fail' THEN 0 ELSE P.AMOUNT END) AS TOTAL_SUCCESSFUL_AMOUNT, 
    SUM(CASE WHEN P.STATUS = 'fail' THEN P.AMOUNT ELSE 0 END) AS TOTAL_FAILED_AMOUNT
FROM orders as O
LEFT OUTER JOIN payments AS P
    ON O.order_id = P.order_id
GROUP BY O.ORDER_ID, O.customer_id