class PlacePolicy < ApplicationPolicy

  class BuyerScope < Scope
  end

  def index?
    user.is_sysop? || user.is_admin?
  end

end
