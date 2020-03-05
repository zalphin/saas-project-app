# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
	:address => 'smtp.sendgrid.net',
	:port => '587',
	:authentication => :plain,
	:user_name => Rails.application.credentials.sendgrid[:username],
	:password => Rails.application.credentials.sendgrid[:pass],
	:domain => 'heroku.com',
	:enable_starttls_auto => true
}