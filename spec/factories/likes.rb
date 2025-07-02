# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gallery_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_gallery_id  (gallery_id)
#  index_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (gallery_id => galleries.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :like do
    user { nil }
    gallery { nil }
  end
end
