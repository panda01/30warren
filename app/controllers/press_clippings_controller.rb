class PressClippingsController < ApplicationController
  with_page :press

  def index
    @press_clippings = PressClipping.order(date: :desc).active.all
  end

  def show
    @press_clipping = PressClipping.active.find(params[:id])
  end
end
