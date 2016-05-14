class CreateArticlesProjects < ActiveRecord::Migration
  def change
    create_table :articles_projects, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :project, index: true
    end
  end
end
