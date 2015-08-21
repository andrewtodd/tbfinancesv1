module TaxesHelper

	def get_tax_for_year(year,country)
		# first we need to figure out which country this is for since the tax years runs
		# between different dates for the US and UK
		if country == 'US'
			start_date = Date.new(year, 01, 01)
			end_date = Date.new(year, 12, 31)
		elsif country == 'UK'
			start_date = Date.new(year, 04, 01)
			end_date = Date.new(year+1, 03, 31)
		else
			return sprintf("ERROR| ? is an invalid country",country)
		end

#		Rails.logger.debug("*********** start date: #{start_date.inspect} end date: #{end_date.inspect}")
		# get all the tranactions for the tax year we're interested in
		tax_year = Transaction.tax_year(start_date,end_date)

#		Rails.logger.debug("*********** tax year: #{tax_year.inspect}")
		## now we need to calulated the 'amount' totals for each tax category
		# 	I thought about using a scope for this but since we know we're going to
		# 	need all categories I thought it would be better for this script to figure
		# 	out the totals
		tax_year_totals = Hash.new()
		tax_year.each do |transaction|

			# we devide the values by 2 as tax is paid per person
			if !tax_year_totals[transaction.category].nil?
				tax_year_totals[transaction.category] = tax_year_totals[transaction.category] + transaction.amount/2
			else
				tax_year_totals[transaction.category] = transaction.amount/2
			end
		end

		Rails.logger.debug("********* tax year totals: #{tax_year_totals}")

		return tax_year_totals

	end
end
