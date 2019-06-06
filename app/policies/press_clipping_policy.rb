class PressClippingPolicy < ApplicationPolicy

  def index?
    user.is_sysop? || user.is_admin?
  end

end
