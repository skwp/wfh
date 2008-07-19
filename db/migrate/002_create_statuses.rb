class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.column :status, :string
      t.column :description, :string
      t.column :color, :string
      t.timestamps
      t.references :user
    end
  end

  def self.down
    drop_table :statuses
  end
end
