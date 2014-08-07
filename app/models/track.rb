class Track < ActiveRecord::Base
  
  validates :name, presence: true
  validates :spotify_reference, presence: true
  validates :duration_ms, presence: true
  validates :popularity, presence: true
  
  belongs_to :album
end
