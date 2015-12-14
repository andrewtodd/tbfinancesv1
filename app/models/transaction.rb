class Transaction < ActiveRecord::Base

	include Filterable

	belongs_to :tennants
	belongs_to :owners

	validates_uniqueness_of :name, :scope => [:date, :amount]

	## START OF UI FILTER SCOPES
	scope :category, -> (category) { where category: category } 

	# I'm not sure these notes will be that much help in the future

	#This is equivalent to the following mysql call:

	# select * from Transactions where category=category  

	# using scope is just like defining a class with a method. These can be called from concerns, controllers etc
	# the first use of category is the name of the class.
	# The second use of category sets the variable 'category' to the value of the paremter being passed to this method when it's called.
	# the third use of category is the column name in the database.
	# The final use of category is again the parameter category.

	#this is the same as writing 
	# def self.category(category)
	#	where ("category = ?", category) the question mark is replaced vy the value of category      
	# end  


  	scope :transaction_type, -> (transaction_type) { where transaction_type: transaction_type }
  	
  	# it seems stupid to accept a param (owner) that won't be used but this hack is the only way to enable
  	# us to use this scope with the filter method which is expecting to send one. We could write some code
  	# to give the method more options but that would slow the process down when we can easily just ignore owener
  	scope :owner, -> (owner) { where.not(owner_id: 'NULL') }
  	
  	## END OF UI FILTER SCOPES


  	scope :tax_year, -> (start_date,end_date) { where("date BETWEEN ? AND ?",start_date,end_date) }
  	scope :business_transactions, -> { where ("owner_id IS NULL") }#used to calculate what owners are owed

  	def self.search(search)
		where("name like ?", "%#{search}%")
	end

	def self.categories
    	#### CATEGORIES
		#     used to populate the categories drop down
		categories = [ 
						['rent','rent'],
						['owner','owner'],
						['tax','tax'],
						['insurance','insurance'],
						['repairs','repairs'],
						['council','council'],
						['tax','tax'],
						['utility','utility'],
						['mortgage','mortgage'],
						['agent','agent'],
						['deposit','deposit'],
						['uncategorized','uncategorized']
			       ]
       return categories
    end


end



