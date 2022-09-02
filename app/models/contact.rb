class Contact < MailForm::Base
  before_deliver :strip_whitespace

  attribute :first_name
  validates :first_name, 
    presence: { message: "Please provide your first name."}, 
    length: { in: 2..20, 
      too_short: "Your first name must be at least %{count} characters long.", 
      too_long: "Your first name cannot be longer than %{count} characters." }

  attribute :last_name
  validates :first_name, 
    presence: { message: "Please provide your last name."}, 
    length: { in: 2..20, 
      too_short: "Your last name must be at least %{count} characters long.", 
      too_long: "Your last name cannot be longer than %{count} characters." }

  attribute :email
  validates :email,
    presence: { message: "Please provide your email address" },
    format: { 
      with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, 
      message: "Please provide a valid email address." }

  attribute :message_subject
  validates :message_subject, 
    presence: { message: "Please provide a subject."}, 
    length: { in: 2..80, 
      too_short: "Subject must be at least %{count} characters long.", 
      too_long: "Subject cannot be longer than %{count} characters." }

  attribute :message
  validates :message, 
    presence: { message: "Please provide your message."}, 
    length: { in: 2..500, 
      too_short: "Message must be at least %{count} characters long.", 
      too_long: "Message cannot be longer than %{count} characters." }

  attribute :nickname,  captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => %(#{message_subject}),
      :to => "info@dbsan.org",
      :reply_to => %(<#{email}>),
      :from => "Contact Form Inquiry <no-reply@dbsan.org>"
    }
  end

  private
    def strip_whitespace
      first_name.strip
      last_name.strip
      email.strip
      message_subject.strip
      message.strip
    end
end