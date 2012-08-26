class VitaeController < ApplicationController
  before_filter :check_auth, :except => :show

  def index
    @vitae = current_user.vitae
  end

  def new
    @vita = Vita.new
  end

  def show
    @vita = Vita.find(params[:id])
    temp_xml = @vita.to_xml
    temp_xml[temp_xml.index("<vita>\n") + 8] = " <photo-url>#{self.request.host}#{@vita.photo.url}</photo-url>\n  "
    render :xml => temp_xml
  end

  def edit
    @vita = current_user.vitae.find(params[:id])
  end

  def create
    @vita = current_user.vitae.new(params[:vita])
    if @vita.save
      redirect_to vitae_path
    else
      render :new
    end
  end

  def update
    @vita = current_user.vitae.find(params[:id])
    if @vita.update_attributes(params[:vita])
      redirect_to vitae_path
    else
      render :new
    end
  end

  def destroy
    @vita = current_user.vitae.find(params[:id])
    @vita.destroy
    redirect_to vitae_path
  end
end