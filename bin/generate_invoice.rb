#!/usr/bin/env ruby

def create_invoice(amount,tennant,description,type)
	invoice = Hash.new
	invoice['amount'] = amount
	invoice['tennant_id'] = tennant
	invoice['description'] = description
	invoice['invoice_type'] = type
	Invoice.create!(invoice)
end

## this script is used to generate monthly invoices for each of our tennants
## 	- this should be ran on the first of every month which gives the tennant a full
## 	  month (20 days longer than contractually required) to make a payment. 
@tennants = Tennant.all

# save properties as hash so we can reference the property using the tennnants property id
properties_hash = Hash[Property.all.map { |p| [p.id, p] }]

@tennants.each do |tennant|
	# STEP 1: Make sure we need to add an invoice for this merchant
	
	## IMPORTANT - FIRST WE HAVE TO CHECK TO SEE IF THE TENNANT IS STILL ACTIVE

	###### we need to make sure this can be ran for several months just in case we forget to run it.
	## 		- to do this we're going to set a last run month rather than last run date.
	## 		- ie 201503 would mean that it was last ran for march of 2015 

	## 		- first month should be free since it's always paid via easilet


	last_run_month = ''
	if !tennant.invoice_last_run.nil?
		last_run_month = tennant.invoice_last_run.strftime("%B")
	end

	puts last_run_month

	current_date = Date.today
	current_month = current_date.strftime("%B")

	puts current_month
	# next if we've already added an invoice this month
	next if current_month == last_run_month

	## STEP 3: we need as to start building the array of arrays that will contain
	## 			the transaction data that will be displayed as a table in the pdf 
	## 			that will be sent as an attachment to the tennant.

	invoice = Array.new()
	# => prawn (pdf creater gem) requires that the header be the first row in the
	#    invoice array
	# => Each transaction will be passed to the invoice array to displayed as a row
	# 	 in the invoice table
	invoice.push(['Date Generated','Description','Amount'])

	## STEP 3: Check to see if any fees need to be added

	## I don't think it's going to be worth calculating interest since the contract states it's charged at 4% above Barclays' base rate on a daily basis. 
	## The cost to run the script would probably be more than we'd collect on interest.

	## IMPORTANT!! fee calculation must be ran before the monthly bill calculation
	## otherwise the merchant will receive a late fee before they have the chance 
	## to pay 

=begin

	total_billed = tennant.invoices.sum(:amount)
	total_paid = tennant.transactions.sum(:amount)
	money_owed = total_billed - total_paid




	if money_owed > 0
		puts "#{tennant.first_name} #{tennant.last_name} has #{money_owed} overdue"
		
		# we are meant to calculate charges daily but that would mean running it on cron and also importing transactions daily.
		# I'm just going to run this a month behind to see if it's even worth using this.

		# people will only be charged it they are more than a month behind on the payment.

		late_fee = (money_owed*0.04)/12 # it's meant to be 4% above barclays bank base rate but since we 
									#don't know what that is daily, we'll just stick with 4% to be safe.
		decimal_late_fee =  sprintf("%.2f",late_fee)

		fee_transaction_description = "late fee based on £#{money_owed} in overdue payments"

		create_invoice(decimal_late_fee,tennant.id,fee_transaction_description,"Fee")

		# we need to convert the decimal to string so that it will display in GBP in the pdf 
		decimal_late_fee_as_string = "£#{decimal_late_fee}"

		fee_transaction_array = [current_date,fee_transaction_description,decimal_late_fee_as_string]
		invoice.push(fee_transaction_array)
	else 
		puts "the tennnant is up to date on their payments"
	end

=end
	# STEP 3: calculate this months base invoice
	monthly_charge = properties_hash[tennant.property_id].monthly_charge

	monthly_transaction_description = "monthly rental charge"
	create_invoice(monthly_charge,tennant.id,monthly_transaction_description,"Rent")

	# we need to convert the decimal to string so that it will display in GBP in the pdf
	monthly_charge_as_string = "£#{monthly_charge}" 

	monthly_transaction_array = [current_date,monthly_transaction_description,monthly_charge_as_string]
	invoice.push(monthly_transaction_array)

	# STEP 4: save invoice to pdf

	pdf = InvoiceReportPdf.new(invoice)
	pdf.render_file "/Sites/tbfinancesv1/app/assets/attachments/invoice.pdf"

	# STEP 5: send invoice to tennant
	TennantMailer.send_invoice(tennant,'Wayne Barker',1111111111,current_month).deliver_now

	# STEP 6: update tennant table to make sure we don't run this again until a month from now
#	tennant.update_attribute(:invoice_last_run,Time.now)

end
