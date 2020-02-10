class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :album_title
      t.string :artist
      t.string :artwork

      t.timestamps
    end
  end
end
