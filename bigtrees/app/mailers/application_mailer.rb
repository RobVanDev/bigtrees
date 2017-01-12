class ApplicationMailer < ActionMailer::Base
  default from: "no-replay@bigtrees.ca"
  layout 'mailer'
  
  ActionMailer::Base.delivery_method = :sendmail

	ActionMailer::Base.sendmail_settings = { :address => "smtp.gmail.com",
     :port => "587", :domain => "gmail.com", :user_name => "xxx@gmail.com", 
    :password => "yyy", :authentication => "plain", :enable_starttls_auto => true }
end
