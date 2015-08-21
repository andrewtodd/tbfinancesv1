class Property < ActiveRecord::Base
		has_many :tennants
		validates :address_line1, presence: true
		validates :city, presence: true
		validates :country, presence: true
		validates :postal_code, presence: true,
				length: { maximum: 7 }
		validates :monthly_charge, presence: true  
end
