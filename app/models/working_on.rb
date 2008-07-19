class WorkingOn < ActiveRecord::Base
  set_table_name 'working_on'
  
  belongs_to :user
  
  class<<self
    def recent
      find(:all, :limit => 15, :order => 'created_at desc')
    end
  end

  def creatable_by?(creator)
    true
  end

  def updatable_by?(updater, new)
    true
  end

  def deletable_by?(deleter)
    deleter==self
  end

  def viewable_by?(viewer, field)
    true
  end
end