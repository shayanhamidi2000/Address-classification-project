WITH grouped_input_transactions AS(
	SELECT ads.address, tx_in.tx_id 
	from public.transaction_inputs tx_in, public.addresses ads 
	where ads.address = tx_in.address_granted 
	group by ads.address, tx_in.tx_id
) 
select git.address, count(*) as tx_cnt, max(tx.block_height) as first_time_tx, min(tx.block_height) as last_time_tx, 
avg(tx.size) as tx_size_avg, max(tx.size) as tx_size_max, min(tx.size) as tx_size_min, stddev_pop(tx.size) as tx_size_std,
avg(tx.num_of_inp) as tx_num_of_inp_avg, max(tx.num_of_inp) as tx_num_of_inp_max, min(tx.num_of_inp) as tx_num_of_inp_min, stddev_pop(tx.num_of_inp) as tx_num_of_inp_std,
avg(tx.num_of_out) as tx_num_of_out_avg, max(tx.num_of_out) as tx_num_of_out_max, min(tx.num_of_out) as tx_num_of_out_min, stddev_pop(tx.num_of_out) as tx_num_of_out_std
from grouped_input_transactions git, public.transactions tx 
where git.tx_id = tx.tx_id 
group by git.address;
