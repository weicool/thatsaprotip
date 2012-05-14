class Protip < ActiveRecord::Base

  belongs_to :user

  has_one :protip_favorites_total_counts
  alias :favorites_count :protip_favorites_total_counts

  has_many :user_favorites

  has_and_belongs_to_many :tags

end
