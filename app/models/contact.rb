class Contact < MailForm::Base
  attribute :first_name,     validate: true
  attribute :last_name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message_subject
  attribute :message
  attribute :nickname,  captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => %(#{message_subject}),
      :to => "patrick.vellia@gmail.com",
      :reply_to => %(<#{email}>),
      :from => "Contact Form Inquiry <info@dbsan.org>"
    }
  end
end