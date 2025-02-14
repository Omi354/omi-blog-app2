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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy


  delegate :display_gender, :display_age, to: :profile, allow_nil: true

  def has_written?(article)
    self.articles.exists?(id: article.id)
  end

  def display_name
    self.profile&.nickname || self.email.split("@").first
  end

  def prepare_profile
    self.profile || self.build_profile
  end

  def avatar_image
    if self.profile&.avatar&.attached?
      self.profile.avatar
    else
      "default-avatar.png"
    end
  end
end
