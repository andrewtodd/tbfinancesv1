class Tennant < ActiveRecord::Base
		belongs_to :property
		has_many :transactions
		has_many :invoices
		validates :first_name, presence: true
		validates :last_name, presence: true
		validates :property_id, presence: true
		validates :email, presence: true
		validates :phone, presence: true
end
