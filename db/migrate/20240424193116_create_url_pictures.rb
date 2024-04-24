class CreateUrlPictures < ActiveRecord::Migration[7.0]
  def change
    create_table :url_pictures do |t|
      t.string :name
      t.string :description
      t.string :page
      t.string :url

      t.timestamps
    end
  end
end
