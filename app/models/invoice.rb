class Invoice < ActiveRecord::Base

	include Filterable

	belongs_to :tennants

	scope :invoice_type, -> (invoice_type) { where invoice_type: invoice_type }

	def self.search(search)
		where("description like ?", "%#{search}%")
	end

end
