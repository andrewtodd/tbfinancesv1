module TransactionsHelper

	include ActionController::MimeResponds

	def update_currency_class(value,css_class)
		if value < 0.00
			css_class = 'negative_value '+ css_class
		elsif value > 0.00
			css_class = 'positive_value '+ css_class
		else
			# css_class does not need to be updated
		end
	return css_class
	end

	def import_file(file)
#		error_log_file = "/Sites/tbfinancesv1/log/error.log"
		row_count = 0
		transactions_imported = 0
		file_name = file.path
  		CSV.foreach(file.path, :headers => true) do |row|
  			row_count += 1
  			csv_hash = row.to_hash

  			Rails.logger.debug(" ******************* csv row #{csv_hash}.inspect")

  			transaction_hash = Hash.new
    		transaction_hash['date'] = csv_hash['Transaction Date']
    		transaction_hash['name'] = csv_hash['Transaction Description'].truncate(255)

    		# the bank csvs have a separate column for credits and debits so we need have to populate type and amount
    		# based on which one is populated for each transaction 
    		if !csv_hash['Debit Amount'].nil?
    			transaction_hash['transaction_type'] = 'debit'
    			transaction_hash['amount'] = "-#{csv_hash['Debit Amount']}"
    		elsif !csv_hash['Credit Amount'].nil?
    			transaction_hash['transaction_type'] = 'credit'
    			transaction_hash['amount'] = "#{csv_hash['Credit Amount']}"
    		else 
    			# something went wrong
    		end

    		# work out the category, owner and tennant values using the transaction 'name'
    		
    		# check to see if this is a tennant transaction
    		@tennants = Tennant.all
    		@tennants.each do |tennant|

    			if !tennant.transaction_description.nil?
	    			lookup_values = tennant.transaction_description.split(',') # tennants can have a list of values that could appear in a deposit

      				lookup_values.each do |value|

      					break unless transaction_hash['tennant'].nil? # skip out in tennant already set in transaction 
      					if /#{value}/.match(transaction_hash['name'])
 							transaction_hash['tennant_id'] = tennant.id
 							transaction_hash['category'] = 'rent'
 						end
 					end  		
    			end
    		end

    		if transaction_hash['category'].nil? || transaction_hash['category'] == ''

	    		# check to see if this is an owner transaction 
    			if /(Andrew Todd|TODD)/.match(transaction_hash['name'])
    				transaction_hash['owner_id'] = 1
					transaction_hash['category'] = 'owner'
	    		elsif /(Wayne Barker|BARKER)/.match(transaction_hash['name'])
    				transaction_hash['owner_id'] = 2
					transaction_hash['category'] = 'owner'
				# check to see if this is an mortgage transaction 
				elsif /MORTGAGE/.match(transaction_hash['name']) || /LEEDS BUILDING SOC/.match(transaction_hash['name'])
					transaction_hash['category'] = 'mortgage'
				# check to see if this is an insurance transaction
				elsif /DGS\/RPP/.match(transaction_hash['name']) || /BRITISH GAS/.match(transaction_hash['name']) ||
					/L&G/.match(transaction_hash['name'])
					transaction_hash['category'] = 'insurance'
				else
					# there is no obvious way to categorize this transaction so need to mark it as uncategorized so that 
					# we know we need to manually assign it
					transaction_hash['category'] = 'uncategorized'
				end
	
			end

			Rails.logger.debug(" ******************* transaction hash #{transaction_hash}.inspect")

			@transaction = Transaction.new(transaction_hash)

			if @transaction.save
				# lets keep a count of how may transactions have been imported so we can display this to the user
				transactions_imported += 1
			else
				# we need to log the error so we can see what went wrong
#				output = File.open(error_log_file,"w" )
#				File.open(error_log_file, 'a') do |file|
				
				time = Time.new()
				@transaction.errors.full_messages.each do |message|
					error_hash = {
						'date' => time,
						'file_row' => row_count,
						'transaction_name' => transaction_hash['name'],
						'error' => message,
						'file_name' => file_name
					}

					@error = ErrorLog.create!(error_hash)
					Rails.logger.debug(" ******************* transaction error #{error_hash}.inspect")

#						output << 
#						file.puts "#{time},#{row_count},#{transaction_hash['name']},#{message}"
#					end
				end

	#			output.close
  			end
  		end
  		return [transactions_imported,row_count]
	end

end
