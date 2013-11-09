class ProtipsController < ApplicationController

  protect_from_forgery

  def index
    @protips = Protip.best
  end

  def like
    protip = Protip.find(params[:id])
    render :json => protip.viewer_liked
  end

  def create
    tags = (params[:protip][:tags] || '').split.map do |tag|
      Tag.find_or_create_by_tag(tag.downcase)
    end
    protip_text = params[:protip][:protip].strip
    if tags.empty? || protip_text.empty?
      redirect_to '/'
      return
    end

    protip = Protip.new :protip => protip_text,
      :user => User.viewer
    protip.tags = tags
    protip.save
    redirect_to '/'
  end

  def fbauth
    #oauth_endpoint = "https://www.facebook.com/dialog/oauth?client_id=378716345523249&redirect_uri=http://thatsaprotip.com&scope=user_likes,publish_actions&state=foo"
    #redirect_to oauth_endpoint
    fb_client.auth_code.authorize_url(
      :redirect_uri => 'http://localhost:3000/protips/fbauth_callback',
      :scope => 'publish_stream'
    )
  end

  def fbauth_callback
    token = fb_client.auth_code.get_token(
      params[:code],
      :redirect_uri => 'http://localhost:3000/protips/fbauth_callback'
    )
    response = token.get('/me')
    render :text => response
  end
end
