class GundamsController < ApplicationController

  # GET /gundams
  def index
    @gundams = GundamMongo.includes(:period).asc(:id).paginate(:page=>params[:page] || 1, :per_page => 20)
  end

  # GET /gundams/1/edit
  def edit
    @gundam = Gundam.find(params[:id])
    @gundam_version = GundamVersion.new(gundam_id: @gundam.id)
  end

  # PUT /gundams/1
  # PUT /gundams/1.json
  def update
    @gundam = Gundam.find(params[:id])
    @version = @gundam.versions.new(params[:gundam])
    if @version.save
      redirect_to @gundam, notice: '您的更改已经保存，请等待管理员审批。'
    else
      @gundam.assign_attributes(params[:gundam])
      render action: :edit
    end
  end

  # GET /gundams/1
  # GET /gundams/1.json
  def show
    @gundam = GundamMongo.find(params[:id])
    @gundam_photos = GundamPhoto.verified.where(gundam_id: params[:id]).order("id desc")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gundam }
    end
  end

end
