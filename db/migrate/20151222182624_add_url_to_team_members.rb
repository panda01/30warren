class AddUrlToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :url, :string
  end
end
