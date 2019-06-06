class BuyerPolicy < ApplicationPolicy

  def index?
    user.is_sysop? || user.is_admin?
  end

  def new?
    false
  end

end
