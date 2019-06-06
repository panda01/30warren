module BuyerPolicyScope
  extend ActiveSupport::Concern

  private

  def buyer_policy_scope(scope)
    policy = Pundit::PolicyFinder.new(scope).policy
    policy::BuyerScope.new(buyer, scope).resolve
  end

end
