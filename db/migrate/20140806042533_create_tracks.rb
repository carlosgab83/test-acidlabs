class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :duration_ms
      t.integer :popularity
      t.string :spotify_reference
      t.belongs_to :album, index: true
      t.datetime :created_at

      t.timestamps
    end
  end
end
