class CreateTextBlockWithLogos < ActiveRecord::Migration
  def change
    create_table :text_block_with_logos do |t|
      t.string :title, limit: 255
      t.text :body, limit: 65535
      t.integer :content_block_id, limit: 4

      t.timestamps null: false
    end
  end
end
