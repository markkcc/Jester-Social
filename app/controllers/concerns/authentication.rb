module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?, :current_user
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def current_user
      Current.user
    end

    def require_authentication
      Current.reset
      resume_session || request_authentication
    end

    def resume_session
      return false unless cookies.signed[:session_id]
      
      session = Session.active.find_by(id: cookies.signed[:session_id])
      return false unless session

      # Delete any other sessions for this user
      session.user.sessions.where.not(id: session.id).destroy_all
      
      # Set the current session
      Current.session = session
      
      # Update the cookie to ensure it's fresh
      cookies.signed.permanent[:session_id] = {
        value: session.id,
        httponly: true,
        same_site: :lax,
        secure: Rails.env.production?,
        domain: Rails.env.production? ? :all : nil
      }
      
      true
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || root_url
    end

    def start_new_session_for(user)
      # Delete all existing sessions for this user
      user.sessions.destroy_all
      
      # Create a new session
      new_session = user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip
      )
      
      # Set the current session
      Current.session = new_session
      
      # Set the session cookie
      cookies.signed.permanent[:session_id] = {
        value: new_session.id,
        httponly: true,
        same_site: :lax,
        secure: Rails.env.production?,
        domain: Rails.env.production? ? :all : nil
      }
      
      new_session
    end

    def terminate_session
      if Current.session
        Current.session.destroy
      end
      Current.reset
      cookies.delete(:session_id)
    end
end
