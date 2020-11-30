class Note < ActiveRecord::Base
    belongs_to :user
    has_many :tags
    validates_presence_of :content
end 