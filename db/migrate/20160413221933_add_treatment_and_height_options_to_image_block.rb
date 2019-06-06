class AddTreatmentAndHeightOptionsToImageBlock < ActiveRecord::Migration
  def change
    add_column :image_blocks, :treatment, :string
    add_column :image_blocks, :height_style, :string
  end
end
