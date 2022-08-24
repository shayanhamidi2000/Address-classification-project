WITH address_interval_difference AS(
	WITH address_interval AS( 
		WITH transaction_time AS( 	
			WITH grouped_input_transactions AS(
				SELECT ads.address, tx_in.tx_id
				from public.transaction_inputs tx_in, public.addresses ads
				where ads.address = tx_in.address_granted
				group by ads.address, tx_in.tx_id
			)
			select git.address, tx.block_height
			from public.transactions tx, grouped_input_transactions git
			where git.tx_id = tx.tx_id
		)
		select tt.address, tt.block_height, LAG(tt.block_height) over (PARTITION BY tt.address order by tt.block_height)  as last_block_height
		from transaction_time tt
	)
	select ai.address, 
	(case when ai.last_block_height is not null then ai.block_height - ai.last_block_height else 0 end) as interv
	from address_interval ai
)
select aid.address, 
max(aid.interv) as max_interval, avg(aid.interv) as avg_interval, stddev_pop(aid.interv) as std_interval
from address_interval_difference aid
group by aid.address;