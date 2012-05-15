class ProtipsController < ApplicationController

  protect_from_forgery

  def index
    @protips = Protip.all
  end
end
