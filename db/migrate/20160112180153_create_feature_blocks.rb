class CreateFeatureBlocks < ActiveRecord::Migration
  def change
    create_table :feature_blocks do |t|
      t.string :title
      t.integer :content_block_id
      t.text :body
      t.text :features
    end

    add_index :feature_blocks, [:content_block_id]
  end
end
