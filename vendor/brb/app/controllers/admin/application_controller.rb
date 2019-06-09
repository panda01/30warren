class Admin::ApplicationController < InheritedResources::Base
  layout 'admin'
  before_action :authenticate_user!

  include Admin::Concerns::PunditLockdown
  include Admin::Concerns::CRUDMethods
  include Admin::Concerns::Taggings

  protected

  def authenticate_user!
    unless current_user && current_user.active?
      redirect_to admin_login_path, notice: 'Please log in'
    end
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end
  helper_method :current_user

  def current_action_also_available_as?(format)
    format = format.to_sym
    responder = self.class.mimes_for_respond_to[format]

    return false if responder.nil?

    only = responder[:only] || [action_name]
    except = responder[:except] || []
    !except.include?(action_name) && only.include?(action_name)
  end
  helper_method :current_action_also_available_as?

end
