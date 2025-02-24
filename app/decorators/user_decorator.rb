# frozen_string_literal: true

module UserDecorator
  def display_name
    self.profile&.nickname || self.email.split("@").first
  end

  def display_gender
    self.profile&.gender || "unknown"
  end

  def avatar_image
    if self.profile&.avatar&.attached?
      self.profile.avatar
    else
      "default-avatar.png"
    end
  end
end
