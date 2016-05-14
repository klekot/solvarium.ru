class AddPrivateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :common, :boolean
  end
end
