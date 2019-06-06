class Buyer::Interest
  include ResourceAttribute
  include BuyerPolicyScope

  attr_accessor :buyer, :places, :sections, :agent

  resource_attribute :amenities,      Amenity
  resource_attribute :local_features, LocalFeature
  resource_attribute :sales_agents,   SalesAgent
  resource_attribute :teams,          TeamMember
  resource_attribute :units,          Unit
  resource_attribute :places,         Place

  delegate :helped_by, :helped_by?, to: :buyer

  def initialize(buyer)
    @buyer = buyer

    resource_attributes! scope: :buyer_policy_scope

    @agent = @sales_agents.where(name: buyer.helped_by).first

    @sections = {
      residences:   [],
      the_building: [],
      neighborhood: [],
      team:         [],
      contact:      []
    }

    @sections.delete(:amenities) unless amenities.any?
    @sections.delete(:team) unless teams.any?
  end

  def addressee
    buyer.full_name
  end

  def date
    buyer.created_at.strftime('%m-%d-%y')
  end

  def message
    buyer.message.presence ||
      (buyer.data.present? && buyer.data[:custom_site].presence) ||
      default_message
  end

  def default_message
    I18n.t('buyer.message.default', full_name: buyer.full_name)
  end

  def contact_phone_number?
    !!agent && agent.phone_number?
  end

  def contact_phone_number
    agent.phone_number
  end

  def contact_name
    agent ? agent.name : helped_by
  end

  def signature_path
    agent.signature.attachment_url(:full_screen)
  end

  def signature_dimensions(width: 180)
    ratio = agent.signature.height.to_f / agent.signature.width.to_f
    { width: width, height: width * ratio }
  end

  def signature?
    agent && agent.signature?
  end

end
