# frozen_string_literal: true

module ProfileDecorator
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
end
