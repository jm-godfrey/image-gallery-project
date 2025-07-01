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

  validates :image, presence: true
  
  # preprocesses the thumbnail of an image on upload
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [nil, 200]
  end

  validate :image_type

  private

  def image_type
    return unless image.attached?

    acceptable_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG, PNG, GIF, or WEBP")
    end
  end

end
