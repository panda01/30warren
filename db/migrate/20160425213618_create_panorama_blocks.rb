class CreatePanoramaBlocks < ActiveRecord::Migration
  def change
    create_table :panorama_blocks do |t|
      t.string :title
      t.string :caption
      t.belongs_to :content_block

      t.timestamps null: false
    end
  end
end
