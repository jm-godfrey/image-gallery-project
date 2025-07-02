# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gallery_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_gallery_id  (gallery_id)
#  index_bookmarks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (gallery_id => galleries.id)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :gallery

  validates :user_id, uniqueness: { scope: :gallery_id }
end
