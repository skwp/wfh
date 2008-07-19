ActionController::Routing::Routes.draw do |map|
  map.home '', :controller => 'front', :action => 'index'
  map.working_on 'working_on', :controller => 'working_on', :action => 'create'
  map.connect 'rss', :controller => 'user_status_updates', :action => 'rss'  
  map.search  'search', :controller => 'front', :action => 'search'
  map.login   'login',  :controller => 'front', :action => 'login'
  map.logout  'logout',  :controller => 'front', :action => 'logout'
  map.signup  'signup', :controller => 'front', :action => 'signup'
  map.statuses  'statuses', :controller => 'statuses', :action => 'index'
  map.users  'users', :controller => 'users', :action => 'index'

  map.homepage ':name', :controller => 'front', :action => 'index', :name => nil

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
