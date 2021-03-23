class TagsController < ApplicationController
  get '/tags' do
    @tags = Tag.all
    erb :'/tag/show'
  end
  get '/tags/new' do
    erb :'/tag/new_tag'
  end
  get '/tag/:id/edit' do
    @tag = Tag.find(params[:id])
    erb :'/tag/edit_tag'
  end
  post '/tags' do
    puts params
      if params[:content] == ""
          redirect to '/tags/new'
      elsif params.has_key?("edit_id")
        tag = Tag.find(params[:edit_id])
        if params.has_key?("delete_me")
          tag.destroy
        else
          tag.update(title: params[:title], name: params[:name])
        end
        redirect to '/tags'
      else
          @tag = Tag.create(title: params[:title], name: params[:name])
          redirect to '/notes'
      end
  end 
  
end