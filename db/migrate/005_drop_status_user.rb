class DropStatusUser < ActiveRecord::Migration
  def self.up
    remove_column :statuses, :user_id
  end

  def self.down
    add_column :statuses, :user_id, :integer
  end
end
