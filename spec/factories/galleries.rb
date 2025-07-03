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
FactoryBot.define do
  factory :gallery do
    sequence(:title) { |n| "Gallery #{n}" }
    description { "MyText" }
    private { false }
    association :user
  end
end
