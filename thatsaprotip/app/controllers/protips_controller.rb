class ProtipsController < ApplicationController

  protect_from_forgery

  def index
    @protips = Protip.best
  end

  def like
    protip = Protip.find(params[:id])
    render :json => protip.viewer_liked
  end
end
