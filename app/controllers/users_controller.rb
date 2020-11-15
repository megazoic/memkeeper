class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/user/show'
    end

    get '/signup' do 
       
        erb :'/user/new'
        
    end 

    post '/signup' do 
        if params[:username] == "" || params[:email] == "" || params[:password] == "" 
            redirect to '/signup'
        else  
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id 
            redirect to '/notes'
        end 
    end 

    get '/login' do 
        if !logged_in?(session)
            erb :'/user/login'
        else
            erb :'/user/show'
        end
    end 

    post '/login' do 
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            erb :'/user/show'
        else
            redirect to '/signup'
        end 
    end     

    get '/logout' do
        if logged_in?(session)
          session.destroy
          redirect to '/login'
        else
          redirect to '/'
        end
    end
end 


#erb /user/show
#<% @user.notes.each do |note| %>
# <li><%= note.content %></li>
# <% end %>