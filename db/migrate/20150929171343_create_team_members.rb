class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
