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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

  validate :password_complexity

  has_many :galleries, dependent: :destroy

  has_many :likes
  has_many :liked_galleries, through: :likes, source: :gallery

  has_many :bookmarks
  has_many :saved_galleries, through: :bookmarks, source: :gallery


  def password_complexity
    return if password.blank?

    unless password =~ /(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])/
      errors.add :password, 'must include at least one lowercase letter, one uppercase letter and one digit'
    end
  end

end
