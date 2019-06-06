class RegistrantMailer < ApplicationMailer
  helper ApplicationHelper

  default from: Rails.application.secrets.registrant_mailer_default_from

  def welcome_email(registrant)
    @registrant = registrant
    attachments.inline['placard.jpg'] = File.read("#{Rails.root}/app/assets/images/mailer/placard.jpg")
    mail to: registrant.email,
         subject: "#{t('project.name')} - Registration"
  end

  def registrant_info(registrant)
    @registrant = registrant
    mail to: Rails.application.secrets.broker_email,
         subject: "#{t('project.name')} - New Registrant"
  end
end
