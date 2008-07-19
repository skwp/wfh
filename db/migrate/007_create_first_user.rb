class CreateFirstUser < ActiveRecord::Migration
  def self.up
    User.create(:username => 'somebody')
  end

  def self.down
  end
end
