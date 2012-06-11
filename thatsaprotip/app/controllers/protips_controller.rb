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
end
