module Filterable
  extend ActiveSupport::Concern

  module ClassMethods

    ## filter
    ## filter is used to filter out records from a database using parameters that it is passed.
    ## It accepts key/value pairs like 'category=>rent' and calls a scope(method) that is defined in the model that is names the same as the key
    ##  eg. if we pass in 'transaction_type=>debit' it will call a scope in the model called 'transaction_type'

    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        if value.present?
          results = results.public_send(key, value) # public_send is used to call a method when the method name is a variable
        end
      end
      return results
    end
  end
end