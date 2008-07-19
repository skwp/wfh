class User < ActiveRecord::Base  
  alias_attribute :display_name, :username
  alias_attribute :login, :username

  # has_many :user_status_updates
  has_many :working_on_statuses, :class_name => "WorkingOn", :order => 'created_at desc' do
    def last
      find(:first)
    end
    
    def limit(n)
      find(:all, :limit => n)
    end
  end
  
  def last_working_status
    working_on_statuses.last || WorkingOn.new(:text => "Nothing new.")
  end

  def last_working_status_update
    working_on_statuses.last && working_on_statuses.last.updated_at || nil
  end

  # --- Hobo Permissions --- #
  
  def super_user?
    login == 'admin'
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


  # --- Fallback permissions --- #

  # (Hobo checks these for models that do not define the *_by? methods)

  def can_create?(obj)
    false
  end

  def can_update?(obj, new)
    false
  end

  def can_delete?(obj)
    false
  end

  def can_view?(obj, field)
    true
  end

  def guest?
    false
  end

end
