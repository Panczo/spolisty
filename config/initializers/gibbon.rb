if Rails.env.test? 
	Gibbon::Export.api_key = "fake" 
	Gibbon::Export.throws_exceptions = false 
end


Gibbon::API.api_key = ENV['MAILCHIMP']
Gibbon::API.timeout = 15
Gibbon::API.throws_exceptions = false
