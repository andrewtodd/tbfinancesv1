class TaxesController < ApplicationController

  def index
  	
  	@tax_years = Array.new()
  	years = params.slice(:year)

  	Rails.logger.debug("***************tax years: #{years}")
  	
  	if years['year'] == 'ALL' || years.nil? || years.empty?
  		@tax_years = (2014..2019)
  	else
  		@tax_years.push(years['year'].to_i)
  	end

  end

end
