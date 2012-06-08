class Protip < ActiveRecord::Base

  belongs_to :user
  alias_method :author, :user

  has_one :protip_favorites_total_count, :dependent => :destroy

  has_many :favorites, :dependent => :destroy
  has_many :favorited_users,
    :through => :favorites,
    :source => :user

  has_and_belongs_to_many :tags

  def favorites_count
    (protip_favorites_total_count && protip_favorites_total_count.count) || 0
  end

  def favorited_by_user?(user)
    favorited_users.include?(user)
  end

  def user_favorited(user)
    favorited = favorited_by_viewer?
    count = ProtipFavoritesTotalCount.find_or_create_by_protip_id(self.id)

    if favorited
      favorited_users.delete(user)
      count.count -= 1
      count.save
    else
      self.favorited_users << user
    end

    { :favorited => !favorited, :count => favorites_count }
  end

  def favorited_by_viewer?
    favorited_by_user?(User.viewer)
  end

  def viewer_favorited
    user_favorited(User.viewer)
  end
end
