class RegistrantsController < ApplicationController

  with_page :contact, only: :new

  def new
    @registrant = Registrant.new
  end

  def create
    @registrant = Registrant.new(registrant_params)
    # dob field should not be present. if so it's spam!
    if params[:dob].present? || params[:registrant][:phone] == '123456'
      render_template 'success'
    elsif @registrant.save
      RegistrantMailer.welcome_email(@registrant).deliver
      RegistrantMailer.registrant_info(@registrant).deliver
      render_template 'success'
    else
      render_template 'form', 'failure'
    end
  end

  private

  def render_template name, status = 'success'
    template = render_to_string(partial: name, layout: false, locals: { registrant: @registrant })
    render json: {
      status: status,
      template: template
    }
  end

  def registrant_params
    params.require(:registrant).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :zip_code,
      :price_range,
      :residence_size,
      :referral_channel
    )
  end

end
