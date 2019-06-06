class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def self.with_page(name, options = {})
    before_action options do
      @page = Page.from_param name.to_s.parameterize.dasherize
    end
  end
end
