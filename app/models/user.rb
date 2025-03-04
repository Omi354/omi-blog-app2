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
  has_many :favorite_articles, through: :likes, source: :article

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  delegate :display_age, to: :profile, allow_nil: true

  def has_written?(article)
    self.articles.exists?(id: article.id)
  end

  def has_liked?(article)
    self.likes.exists?(article_id: article.id)
  end

  def has_followed?(user)
    self.followings.exists?(user.id)
  end

  def follow!(user)
    self.following_relationships.create!(following_id: user.id)
  end

  def unfollow!(user)
    relationship = self.following_relationships.find_by!(following_id: user.id)
    relationship.destroy!
  end

  def prepare_profile
    self.profile || self.build_profile
  end
end
