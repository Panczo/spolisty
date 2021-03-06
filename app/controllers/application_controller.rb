class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  rescue_from ActionController::RoutingError do
    raise :test
    render_404
  end

  def set_locale
    begin
      country_code = request.try(:location).try(:country_code) || "en"
    rescue => e
      # handle the error here
      logger.debug "http://freegeoip.net must be down!"
      logger.debug e.message
    end

    if country_code
      country_code = country_code.downcase.to_sym
      country_code == :pl ? l = :pl : l = :en
    else
      l = I18n.default_locale
    end

    I18n.locale = l
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in)        { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :about, :password, :password_confirmation, :current_password) }
  end

  private

  def redirect_back_or(path)
    redirect_to request.referer || path
  end
  
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end


end
