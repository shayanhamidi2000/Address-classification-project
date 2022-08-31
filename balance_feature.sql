select tx_out.address_spent, sum(tx_out.value_sat) as balance
from public.transaction_outputs tx_out
where (tx_out.tx_id, tx_out.indx) not in (select spent_from_tx, spent_from_indx from public.transaction_inputs)
group by tx_out.address_spent;
