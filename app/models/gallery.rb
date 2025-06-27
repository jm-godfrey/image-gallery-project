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
class Gallery < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  scope :publicly_visible, -> { where(private: false)}
end
