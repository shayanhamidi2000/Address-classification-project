SELECT address, count(adds.address) as address_out_count, sum(tx_out.value_sat) as sum_spent, 
    max(tx_out.value_sat) as max_spent, min(tx_out.value_sat) as min_spent, avg(tx_out.value_sat) as avg_spent, stddev_pop(tx_out.value_sat) as std_spent
FROM public.addresses adds, public.transaction_outputs tx_out
WHERE adds.address = tx_out.address_spent
group by adds.address;
