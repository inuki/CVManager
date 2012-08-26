class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :app_config

  private

  def app_config
    @app_config ||= YAML.load_file("#{Rails.root}/config/cv_manager.yml")["config"]
  end

  def check_auth
    unless current_user
      redirect_to new_session_path, alert: "Something goes wrong!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
