require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :open_id, :identifier => 'https://www.google.com/accounts/o8/id'
end
