# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!@).*/ }

  validates :content, presence: true

  has_one_attached :eye_catch
  has_rich_text :content

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  validate :validate_content_length
  validate :minimum_length_title_and_content

  def display_created_at
    I18n.l self.created_at, format: :short
  end

  def author_name
    self.user.display_name
  end

  private
  def validate_content_length
    if content.present? && content.body.to_plain_text.length < 10
      errors.add(:content, "は10文字以上で入力してください")
    end
  end

  def minimum_length_title_and_content
    content_length = content.body.to_plain_text.length
    char_length = title.length + content_length
    minimum_length = 20
    errors.add(:content, "#{minimum_length}文字以上の入力が必要です") if char_length <= minimum_length
  end
end
