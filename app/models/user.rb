class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles

  def has_written?(article)
    self.articles.exists?(id: article.id)
  end

  def display_name
    self.email.split("@").first
  end
end
