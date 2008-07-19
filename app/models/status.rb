class Status < ActiveRecord::Base

  

  def to_s
    status
  end
  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    true
  end

  def updatable_by?(updater, new)
    true
  end

  def deletable_by?(deleter)
    true
  end

  def viewable_by?(viewer, field)
    true
  end

end
