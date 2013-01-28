class GundamsController < ApplicationController

  # GET /gundams
  def index
    @gundams = GundamMongo.includes(:period).asc(:id).paginate(:page=>params[:page] || 1, :per_page => 20)
  end

  # GET /gundams/1
  # GET /gundams/1.json
  def show
    @gundam = GundamMongo.find(params[:id])
    @gundam_photos = GundamPhoto.where(gundam_id: params[:id]).order("id desc")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gundam }
    end
  end

end
