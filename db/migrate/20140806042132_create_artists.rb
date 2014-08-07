class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_reference
      t.datetime :created_at

      t.timestamps
    end
  end
end
