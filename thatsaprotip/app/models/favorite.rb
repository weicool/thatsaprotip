class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :protip

  before_save :update_count

  private

  def update_count
    conditions = { :user_id => user.id, :protip_id => protip.id }
    count = ProtipFavoritesTotalCount.find_or_create_by_protip_id(protip.id)
    count.count = count.count + 1
    count.save
  end

end
