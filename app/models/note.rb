class Note < ActiveRecord::Base
    belongs_to :user
    has_one :tag
    validates_presence_of :content
end 