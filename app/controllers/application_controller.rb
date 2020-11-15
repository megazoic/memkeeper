class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    enable :sessions
    set :session_secret, "my_application_secret"
    set :views, "app/views"

    get '/' do 
        erb :index
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