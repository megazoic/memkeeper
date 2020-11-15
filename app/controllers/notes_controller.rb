class NotesController < ApplicationController
    
    get '/notes' do 
        @note = Note.find_by_id(params[:id])
        if logged_in?(session)
            erb :'/user/show'
        else
            redirect to '/login'
        end
    end 

    get '/notes/new' do 
        if logged_in?(session)
            erb :'/note/new_note'
        else
            redirect to '/login'
        end
    end 
    
    post '/notes' do 
        if params[:content] == ""
            redirect to '/notes/new'
        else
            @note = Note.create(content: params[:content])
            current_user.notes << @note
            redirect to '/notes'
        end
    end 

    get '/notes/:id' do 
        if logged_in?(session)
            @note = Note.find_by_id(params[:id])
            erb :'/note/single_note'
        else
            redirect to '/login'
        end
    end 

    get '/notes/:id/edit' do 
        if logged_in?(session)
            @note = Note.find_by_id(params[:id])
            if @note && @note.user == current_user
                erb :'/note/edit_note'
            else
                redirect to '/notes'
            end
        else
            redirect to '/login'
        end
    end

    patch '/notes/:id' do 
        @note = Note.find_by_id(params[:id])

        if params[:content] == ""
            redirect to '/notes/#{@note.id}/edit'
        else
            @note.update(content: params[:content])
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