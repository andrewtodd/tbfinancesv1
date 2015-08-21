class ErrorLogsController < ApplicationController
  def index

	@error_logs = ErrorLog.all 

#  	error_log_file = "/Sites/tbfinancesv1/log/error.log"
#  	@logged_errors = Array.new()
  	

#  	begin
#	    file = File.new(error_log_file, "r")
#	    while (logged_error = file.gets)
#    	    error_columns = logged_error.split(",")
#    	    @logged_errors.push({'date' => error_columns[0], 'file_column' => error_columns[1], 'transaction_name' => error_columns[2], 'error' => error_columns[3]})
#	    end
#    	file.close
#	rescue => err
#   	puts "Exception: #{err}"
#    	err
#	end
  end
  
end
