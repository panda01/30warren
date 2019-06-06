class BuyersController < ApplicationController

  layout 'buyer'

  def show
    @dashboard = Buyer::Interest.new current_tenant
  end

  protected

    def current_tenant
      @current_tenant ||= Buyer.from_param(request.subdomain)
    end
    helper_method :current_tenant

end
