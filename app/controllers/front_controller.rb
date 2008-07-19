class FrontController < ApplicationController  
  filter_parameter_logging "password"
  
  def index
    if params[:name]
      u = User.find(:first, :conditions => ['username = ?', params[:name]])
      return unless u
      @current_user = u
      @default_user_id = u[:id]
      @default_status = 1
    end
  end

  def search
    if request.post?
      site_search(params[:query])
    end
  end

  def login
    return unless request.post?
    user = Hobo.user_model.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token ,
                                 :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:action => 'index')
      flash[:notice] = "You have logged in"
    else
      flash[:notice] = "You did not provide a valid login and password"
    end
  end

  def signup
    @user = Hobo.user_model.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:action => 'index')
  end

end
