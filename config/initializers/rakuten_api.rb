RakutenWebService.configure do |c|
  c.application_id = Rails.application.credentials.rakuten[:app_id]
  c.affiliate_id = Rails.application.credentials.rakuten[:af_id]
end