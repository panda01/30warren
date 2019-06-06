class Unit < ActiveRecord::Base
  include Brb::Model::Full
  include Concerns::FallbackDelegate
  include AASM

  AREA_FIELDS = %i[interior exterior].product(%i[feet meters]).map do |(orientation, unit)|
    "#{orientation}_square_#{unit}"
  end

  validates_presence_of :floor, :letter, :unit_type

  has_heading 'Residence', link: 'floor', display: 'door_number', default: true
  has_heading 'Price', link: 'price'
  has_heading 'Status', link: 'status'
  has_heading 'Premium', link: 'premium'
  has_heading 'Active', link: 'active'

  delegate :text_blocks,
           to: :unit_type

  soft_delegate :floor_plans,
                :floor_plan_pdf,
                :renderings,
                :has_terace,
                :description,
                :description?,
                :penthouse?,
                :duplex?,
                to: :unit_type

  fallback_delegate *AREA_FIELDS,
                    :number_of_bedrooms,
                    :number_of_bathrooms,
                    :number_of_powder_rooms,
                    to: :unit_type

  belongs_to :unit_type

  has_images :views

  aasm column: :status do
    state :available, initial: :true
    state :not_available
    state :contract_pending
    state :contract_signed
    state :sold
  end

  def self.available_styles
    active
      .includes(:unit_type)
      .sort_by(&:group_index)
      .collect(&:group)
      .uniq
  end

  def name
    if penthouse? || duplex?
      door_number
    else
      I18n.t('unit.name', number: door_number)
    end
  end

  def door_number
    if penthouse?
      "PH#{letter}"
    elsif duplex?
      "Duplex"
    else
      "#{floor}#{letter}"
    end
  end

  def humanized_status
    # Pulls "translated" values from en.yml locale
    aasm.human_state
  end

  def area
    Area.new({
      imperial: {
        interior: interior_square_feet,
        exterior: exterior_square_feet
      },
      metric: {
        interior: interior_square_meters,
        exterior: exterior_square_meters
      }
    })
  end

  def area?
    area.total > 0
  end

  def price
    Money.new super
  end

  def price=(value)
    super Money.new(value)
  end

  def monthly_taxes
    Money.new super
  end

  def monthly_taxes=(value)
    super Money.new(value)
  end

  def monthly_charges
    Money.new super
  end

  def monthly_charges=(value)
    super Money.new(value)
  end

  def show_floor_plan_pdf?
    floor_plans.any? &&
      floor_plan_pdf.present? &&
      floor_plan_pdf.attachment_url.present?
  end

  def group
    UnitGroup.new(self)
  end

end
