class UnitsController < ApplicationController

  with_page :availability

  def index
    @units = Unit.order(number_of_bedrooms: :desc).active
  end

  def show
    @unit = Unit.find(params[:id])
  end
end
