class TennantMailer < ApplicationMailer
	default from: "tbproperties1@gmail.com"
	default format: "html"

	def send_invoice(tennant,owner,telephone,month)
		@tennant = tennant
		@owner = owner
		@telephone = telephone
		@month = month

		## added , mode: "rb" to the end of the file address as windows can't read the file
		## and it is therefore sent blank
		attachments["#{month}_invoice.pdf"] = File.read("#{Rails.root}/app/assets/attachments/invoice.pdf", mode: "rb") 
		mail(to: @tennant.email, subject: "#{month} invoice")
	end
end
