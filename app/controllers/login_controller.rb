class LoginController < ApplicationController

  protect_from_forgery

  def fbauth
    oauth_url = "https://www.facebook.com/dialog/oauth?client_id=240571606061299&redirect_uri=http://localhost:3000/login/fbauth_callback&scope=user_likes,publish_actions&state=foo"
    redirect_to oauth_url
  end

  def fbauth_callback
    require('open-uri')
    token_url = "https://graph.facebook.com/oauth/access_token?client_id=240571606061299&redirect_uri=http://localhost:3000/login/fbauth_callback&client_secret=2fb742e821ffeaf65fb06d23daf8371a&code=#{params[:code]}"
    token = open(token_url).read.match(/access_token=([^&]+)/)[1]
    session[:fbtoken] = token
    render :text => token
  end
end
