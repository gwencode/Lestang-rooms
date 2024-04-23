class AddDescriptionToPictures < ActiveRecord::Migration[7.0]
  def change
    add_column :pictures, :description, :string
  end
end
