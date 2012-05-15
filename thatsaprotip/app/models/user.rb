class User < ActiveRecord::Base

  has_many :protips

  has_many :favorites
  has_many :favorited_protips,
    :through => :favorites,
    :source => :protip

end
