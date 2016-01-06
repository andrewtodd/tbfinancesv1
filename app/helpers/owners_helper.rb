module OwnersHelper

	def get_amount_owed (owner)
		@owner = owner
		@business_transactions = Transaction.business_transactions() # in order to work out how much each owner
		# is owed, we need the sum of the transactions after owner transactions are taken out.

		Rails.logger.debug("***************btrans: #{@business_transactions.inspect}")

		# we only use 50% of the transaction sum because we're only dealing with 1 owner 
		business_transaction_sum = @business_transactions.sum(:amount)/2

		# !! this is very important. The transactions include a starting balance that was carried over from the
		# old system. This is not a business transaction but will be returned in @business_transactions, so 
		# we'll need to deduct it. 
		account_starting_balance = 3586.82

		Rails.logger.debug("***************btrans sum: #{business_transaction_sum}")
		

		owner_transaction_sum = @owner.transactions.sum(:amount)  

		Rails.logger.debug("***************owner trans sum: #{owner_transaction_sum}")		


		# we use plus here because if the owner transaction amount was a debit from the account (which is most likely)
		# it will be recorded as a debit and therefore be a negative number.

		# because we transfered our finances to this app we need to set a starting balance so that amount
		# owed considers what each owner owed prior to moving to this system.
		if owner.id == 1
			owner_starting_balance = -98.28
		elsif owner.id == 2
			owner_starting_balance = 3685.1
		else 
			owner_starting_balance = 0
		end

		Rails.logger.debug("***************starting_balance: #{starting_balance}")

		# eg if the business owner transaction sum is 2000 (meaning between owners we're 4000 in profit) 
		# and 1 owner takes 1000, the amount the owner is owed would be:
		# 	2000 + (-1000) = 1000. He would still be owed 1000  
		amount_owed = (business_transaction_sum - account_starting_balance) + (owner_transaction_sum + starting_balance)

		Rails.logger.debug("***************amount_owed: #{amount_owed}")

		return amount_owed
	end
end
