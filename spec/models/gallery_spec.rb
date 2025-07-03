# == Schema Information
#
# Table name: galleries
#
#  id          :bigint           not null, primary key
#  description :text
#  private     :boolean
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_galleries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe '.most_liked' do
    it 'orders galleries by like count descending' do
      less_liked = create(:gallery)
      more_liked = create(:gallery)
      create_list(:like, 3, gallery: more_liked)
      create_list(:like, 1, gallery: less_liked)

      expect(Gallery.most_liked).to eq([more_liked, less_liked])
    end
  end
end
