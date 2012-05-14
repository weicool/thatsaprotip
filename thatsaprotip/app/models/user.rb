class User < ActiveRecord::Base

  has_many :protips
  has_many :user_favorites

end
