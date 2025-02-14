# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum :gender, [ :male, :female, :non_binary ]
  belongs_to :user

  def display_age
    if self.birthday.nil?
      return "？歳"
    end

    today = Time.zone.today
    this_years_birthday = Time.zone.local(today.year, self.birthday.month, self.birthday.day)
    age = today.year - self.birthday.year
    age -= 1 if today < this_years_birthday

    "#{age}歳"
  end

  def display_gender
    self.gender || "unknown"
  end
end
