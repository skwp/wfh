class CreateWorkingOn < ActiveRecord::Migration
  def self.up
    create_table :working_on do |t|
      t.references :user      
      t.text :text
      t.timestamps
    end
  end

  def self.down
    drop_table :working_on
  end
end
