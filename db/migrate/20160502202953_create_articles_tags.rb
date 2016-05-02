class CreateArticlesTags < ActiveRecord::Migration
  def change
    create_table :articles_tags, id: false do |t|
      t.belongs_to :articles, index: true
      t.belongs_to :tags, index: true
    end
  end
end
