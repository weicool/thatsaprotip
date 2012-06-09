class User < ActiveRecord::Base

  has_many :protips

  has_many :likes
  has_many :liked_protips,
    :through => :likes,
    :source => :protip

  def self.viewer
    return User.first
  end

end
