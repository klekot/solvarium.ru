class CreateArticlesProjects < ActiveRecord::Migration
  def change
    create_table :articles_projects, id: false do |t|
      t.belongs_to :articles, index: true
      t.belongs_to :projects, index: true
    end
  end
end
