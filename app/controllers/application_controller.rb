require 'active_support/core_ext/time'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    enable :sessions
    set :session_secret, "my_application_secret"
    set :views, "app/views"

    get '/' do 
        erb :index
    end
    before do # need to comment this for RSpec
      next if request.path_info == '/login'
      if session[:user_id].nil?
        redirect '/login'
      end
    end
    helpers do 
        def logged_in?(session)
            !!session[:user_id]
        end 
        
        def current_user 
            User.find(session[:user_id])
        end 
    end 
end 