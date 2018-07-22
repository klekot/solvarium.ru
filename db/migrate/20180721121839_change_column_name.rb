class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :projects, :user_id, :creator_id
  end
end
