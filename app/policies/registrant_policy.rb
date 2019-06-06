class RegistrantPolicy < ApplicationPolicy

  def update?
    user.is_sysop? || user.is_admin?
  end

  def create?
    user.is_sysop? || user.is_admin?
  end

end
