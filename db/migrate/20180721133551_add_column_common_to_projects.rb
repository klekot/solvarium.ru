class AddColumnCommonToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :common, :integer, null: false, default: 0
  end
end
