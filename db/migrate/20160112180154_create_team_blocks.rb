class CreateTeamBlocks < ActiveRecord::Migration
  def change
    create_table :team_blocks do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.integer :content_block_id
      t.text :body
    end

    add_index :team_blocks, [:content_block_id]
  end
end
