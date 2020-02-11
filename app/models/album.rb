class Album < ApplicationRecord
    validates :album_title, presence: true
    validates :artist, presence: true
end
