class UsersController < ApplicationController
  active_scaffold :user do |config|
    config.columns = [:username]
  end
  
end
