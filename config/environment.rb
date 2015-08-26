# Load the Rails application.
require File.expand_path('../application', __FILE__)

require 'omniauth-facebook'

configure do
  use OmniAuth::Builder do
    provider :facebook, ENV['APP_ID'], ENV['APP_SECRET']
  end
end

Rails.application.initialize!
