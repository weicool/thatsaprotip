class Protip < ActiveRecord::Base

  belongs_to :user
  alias_method :author, :user

  has_one :protip_likes_total_count, :dependent => :destroy

  has_many :likes, :dependent => :destroy
  has_many :liked_users,
    :through => :likes,
    :source => :user

  has_and_belongs_to_many :tags

  def likes_count
    (protip_likes_total_count && protip_likes_total_count.count) || 0
  end

  def liked_by_user?(user)
    liked_users.include?(user)
  end

  def user_liked(user)
    liked = liked_by_viewer?
    count = ProtipLikesTotalCount.find_or_create_by_protip_id(self.id)

    if liked
      liked_users.delete(user)
      count.count -= 1
      count.save
    else
      self.liked_users << user
    end

    { :liked => !liked, :count => likes_count }
  end

  def liked_by_viewer?
    liked_by_user?(User.viewer)
  end

  def viewer_liked
    user_liked(User.viewer)
  end
end
