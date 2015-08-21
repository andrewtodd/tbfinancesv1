# Preview all emails at http://localhost:3000/rails/mailers/tennant_mailer
class TennantMailerPreview < ActionMailer::Preview

  def send_invoice_preview
    TennantMailer.send_invoice(Tennant.first)
  end
end

