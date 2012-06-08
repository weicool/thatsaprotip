class ProtipsController < ApplicationController

  protect_from_forgery

  def index
    @protips = Protip.all
  end

  def favorite
    protip = Protip.find(params[:id])
    render :json => protip.viewer_favorited
  end
end
