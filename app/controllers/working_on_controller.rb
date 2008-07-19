class WorkingOnController < ApplicationController
  session :off
  
  
  def create
    wo = WorkingOn.create(:user => User.find_by_username(params[:user]), :text => params[:text])
    
    render :update do |page|
      page.replace_html "working-on", :partial => 'working_on'
      page.visual_effect :highlight, 'working-on', {:endcolor => '#F1F4FA'}
    end    
  end
end