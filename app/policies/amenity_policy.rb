class AmenityPolicy < ApplicationPolicy
  class BuyerScope < Scope

    def resolve
      scope.positioned.active
    end

  end

  def index?
    user.is_sysop? || user.is_admin?
  end
end
