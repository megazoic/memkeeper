class NotesController < ApplicationController
    
    get '/notes' do 
        @notes = current_user.notes
        #puts @note.methods.sort
        #current_user.notes.each do |note|
        #    puts "content: #{note.content}, time: #{note.ts.localtime}, tn: #{note.tag_id}"
        #end
        erb :'/user/show'
    end 

    get '/notes/new' do
      @tags = Tag.all
      erb :'/note/new_note'
    end 
    
    post '/notes' do
        if params[:content] == ""
            redirect to '/notes/new'
        else
          note = Note.create(content: params[:content], ts: Time.now(), tag_id: params["tag"], title: params[:title])
          current_user.notes << note
          redirect to '/notes'
        end
    end 

    get '/notes/:id' do 
            @note = Note.find_by_id(params[:id])
            @tag = Tag.find(@note.tag_id)
            erb :'/note/single_note'
    end 

    get '/notes/:id/edit' do 
            @note = Note.find_by_id(params[:id])
            @tags = Tag.all
            if @note && @note.user == current_user
                erb :'/note/edit_note'
            else
                redirect to '/notes'
            end
    end

    post '/notes/:id' do 
        @note = Note.find_by_id(params[:id])

        if params[:content] == ""
            redirect to '/notes/#{@note.id}/edit'
        else
            @note.update(content: params[:content], tag_id: params[:tag], title: params[:title])
            redirect to '/notes'
        end
    end 

    delete '/notes/:id/delete' do 
        @note = Note.find_by_id(params[:id])

        if @note && @note.user == current_user
            @note.destroy
            redirect to '/notes'
        else
            redirect to '/login'
        end
    end 
end 