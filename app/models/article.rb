# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true
  validate :minimum_length_title_and_content

  belongs_to :user

  def display_created_at
    I18n.l self.created_at, format: :short
  end

  private
  def minimum_length_title_and_content
    char_length = self.title.length + self.content.length
    minimum_length = 50
    errors.add(:content, "100文字以上の入力が必要です") if char_length <= minimum_length
  end
end
