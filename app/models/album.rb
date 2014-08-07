class Album < ActiveRecord::Base
  
  validates :name, presence: true
  validates :spotify_reference, presence: true
  validates :release_date, presence: true
  #OJO PROBAR CON VALIDATES ARTIST ID
  
  belongs_to :artist
  has_many :tracks, inverse_of: :album
  accepts_nested_attributes_for :tracks 
  
end
