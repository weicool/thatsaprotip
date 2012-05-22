class Protip < ActiveRecord::Base

  belongs_to :user
  alias_method :author, :user

  has_one :protip_favorites_total_count

  has_many :favorites
  has_many :favorited_users,
    :through => :favorites,
    :source => :user

  has_and_belongs_to_many :tags

  def favorites_count
    (protip_favorites_total_count && protip_favorites_total_count.count) || 0
  end

end
