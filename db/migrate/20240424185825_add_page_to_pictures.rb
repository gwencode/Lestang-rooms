class AddPageToPictures < ActiveRecord::Migration[7.0]
  def change
    add_column :pictures, :page, :string
  end
end
