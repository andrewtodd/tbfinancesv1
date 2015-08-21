module InvoicesHelper
	
	def name_with_initial(tennant_id)
		@tennants_hash = Hash[Tennant.all.map { |t| [t.id, t] }]
		full_name = @tennants_hash[tennant_id].first_name.first + ' ' + @tennants_hash[tennant_id].last_name
		return full_name
	end
end
