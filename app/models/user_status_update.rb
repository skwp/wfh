class UserStatusUpdate < ActiveRecord::Base
  belongs_to :user
  belongs_to :status
  
  class<<self
    def recent
      find(:all, :limit => 15, :order => 'created_at desc', :conditions => ["date >= ?", Date.today.to_s(:db)])
    end
  end
  
  def unknown?
    self.status.status == "Unknown"
  end
  
  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    creator==user
  end

  def updatable_by?(updater, new)
    updater==user
  end

  def deletable_by?(deleter)
    true
  end

  def viewable_by?(viewer, field)
    true
  end

end
