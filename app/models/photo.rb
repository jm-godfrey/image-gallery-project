# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gallery_id :bigint           not null
#
# Indexes
#
#  index_photos_on_gallery_id  (gallery_id)
#
# Foreign Keys
#
#  fk_rails_...  (gallery_id => galleries.id)
#
class Photo < ApplicationRecord
  belongs_to :gallery
  has_one :user, through: :gallery

  has_one_attached :image
end
