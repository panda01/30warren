class AddLinkTextToFileBlocks < ActiveRecord::Migration
  def change
    add_column :file_blocks, :link_text, :string
  end
end
