class PagesController < ApplicationController

  def show
    if params[:id].present?
      @page = Page.where(slug: params[:id]).first
    else
      @page = Page.where(slug: 'home').first
    end

    @registrant = Registrant.new
    @team_members = TeamMember.positioned.active
  end

end
