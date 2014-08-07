class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.date :release_date
      t.string :spotify_reference
      t.belongs_to :artist, index: true
      t.datetime :created_at

      t.timestamps
    end
  end
end
