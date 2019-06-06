# Preview all emails at http://localhost:3000/rails/mailers/registrant_mailer
class RegistrantMailerPreview < ActionMailer::Preview

  def welcome
    RegistrantMailer.welcome_email(OpenStruct.new(email: 'foo@bar.com'))
  end

end
