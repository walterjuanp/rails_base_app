class ApplicationController < ActionController::Base
  protect_from_forgery # See at ActionController::RequestForgeryProtection
  
  helper_method :current_user_session, :current_user
  
  before_filter :set_locale

  ELEMS_PER_PAGE = 10

  ##########################
  # PRIVATE METHODS
  ##########################
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    logger.debug "* ApplicationController::require_user"
    unless current_user
      flash[:notice] = I18n.terr('logged_in_to_access')
      redirect_to root_url
      return false
    end
  end
  
  def require_no_user
    logger.debug "* ApplicationController::require_no_user"
    if current_user
      flash[:notice] = I18n.terr('logged_out_to_access')
      redirect_to root_url
      return false
    end
  end
  
  # 
  # Set locale
  # 
  def set_locale
    extracted_locale = params[:locale]  || 
                       session[:locale] ||
                       extract_locale_from_accept_language_header
    logger.debug "* Locale recived: #{extracted_locale}"
    I18n.locale = (I18n.available_locales.include? extracted_locale.to_sym) ? extracted_locale : I18n.default_locale
    session[:locale] = I18n.locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
  # Get locale from "Accept-Language" HTTP Header or return nil if such locale is not available
  #   example: Accept-Language: da, en-gb;q=0.8, en;q=0.7
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
