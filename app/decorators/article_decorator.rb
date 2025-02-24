# frozen_string_literal: true

module ArticleDecorator
  def display_created_at
    I18n.l self.created_at, format: :short
  end

  def author_name
    self.user.display_name
  end
end
