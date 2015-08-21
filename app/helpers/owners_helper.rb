module OwnersHelper

	def get_amount_owed (owner)
		@owner = owner
		@business_transactions = Transaction.business_transactions() # in order to work out how much each owner
		# is owed, we need the sum of the transactions after owner transactions are taken out.

		Rails.logger.debug("***************btrans: #{@business_transactions.inspect}")

		# we only use 50% of the transaction sum because we're only dealing with 1 owner 
		business_transaction_sum = @business_transactions.sum(:amount)/2

		owner_transaction_sum = @owner.transactions.sum(:amount)  

		# we use plus here because if the owner transaction amount was a debit from the account (which is most likely)
		# it will be recorded as a debit and therefore be a negative number.

		# eg if the business owner transaction sum is 2000 (meaning between owners we're 4000 in profit) 
		# and 1 owner takes 1000 amount the owner is owed owed would be:
		# 	2000 + (-1000) = 1000. He would still be owed 1000  
		amount_owed = business_transaction_sum + owner_transaction_sum

		return amount_owed
	end
end
