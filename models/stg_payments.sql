select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    STATUS as status,
    to_number(amount / 100) AS amount,
    created as created

from raw.stripe.payment