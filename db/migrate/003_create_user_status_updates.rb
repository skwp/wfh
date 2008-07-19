class CreateUserStatusUpdates < ActiveRecord::Migration
  def self.up
    create_table :user_status_updates do |t|
      t.references :user, :status
      t.timestamps
      t.column :date, :date
    end
  end

  def self.down
    drop_table :user_status_updates
  end
end
