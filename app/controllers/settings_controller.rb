class SettingsController < ApplicationController


  def show

  end

  def create
    new_config = {
        "config" => {
          "company_name" => params[:company_name],
          "bird_url" => params[:bird_url]
      }
    }
    File.open("#{Rails.root}/config/cv_manager.yml", 'w') {|f| f.write(new_config.to_yaml) }
    redirect_to settings_path
  end
end
