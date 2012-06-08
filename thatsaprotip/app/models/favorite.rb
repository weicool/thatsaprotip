class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :protip

  after_create  :increment_count

  private

  def increment_count
    count = ProtipFavoritesTotalCount.find_or_create_by_protip_id(protip.id)
    count.count += 1
    count.save
  end
end
