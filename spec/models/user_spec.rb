# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a username" do
    user = FactoryBot.build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it "is invalid if passwords don't match" do
    user = FactoryBot.build(:user, password_confirmation: "wrong")
    expect(user).not_to be_valid
  end
end
