Rails.configuration.stripe = {
	:publishable_key => Rails.application.credentials.stripe[:test_publishable],
	:secret_key => Rails.application.credentials.stripe[:test_secret]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]