class ApplicationController < ActionController::Base

  protect_from_forgery

  def fb_client
    require 'oauth2'

    OAuth2::Client.new(
      '240571606061299',
      '2fb742e821ffeaf65fb06d23daf8371a',
      :site => 'https://graph.facebook.com',
      :token_url => '/oauth/access_token',
      :ssl => { :verify => false }
    )
  end
end
