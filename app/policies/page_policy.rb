class PagePolicy < ApplicationPolicy

  def index?
    user.is_sysop? || user.is_admin?
  end

  def destroy?
    user.is_sysop?
  end

  def create?
    user.is_sysop?
  end

  def edit?
    user.is_sysop?
  end

end
