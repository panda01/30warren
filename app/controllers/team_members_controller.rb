class TeamMembersController < ApplicationController

  with_page :the_team

  def index
    @page = Page.from_param('the-team')
    @team_members = TeamMember.positioned.all
    @jump_links = @team_members
    @jump_links_attr = :name
  end
end
