class Owner < ActiveRecord::Base
	has_many :transactions
end
