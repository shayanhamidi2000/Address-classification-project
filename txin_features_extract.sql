SELECT address, count(adds.address) as address_in_count, sum(tx_in.value_sat) as sum_granted, 
    max(tx_in.value_sat) as max_granted, min(tx_in.value_sat) as min_granted, avg(tx_in.value_sat) as avg_granted, 
    max(tx_in.indx) as max_input_index, min(tx_in.indx) as min_input_index, avg(tx_in.indx) as avg_input_index, 
    max(tx_in.spent_from_indx) as max_output_index, min(tx_in.spent_from_indx) as min_output_index, avg(tx_in.spent_from_indx) as avg_output_index
FROM public.addresses adds, public.transaction_inputs tx_in
WHERE adds.address = tx_in.address_granted
group by adds.address;