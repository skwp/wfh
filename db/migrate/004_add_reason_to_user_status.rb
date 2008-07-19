class AddReasonToUserStatus < ActiveRecord::Migration
  def self.up
    add_column :user_status_updates, :description, :text
  end

  def self.down

    remove_column :user_status_updates, :description
  end
end
