class AddUserIdToArticle < ActiveRecord::Migration[8.0]
  def change
    add_reference :articles, :user
  end
end
