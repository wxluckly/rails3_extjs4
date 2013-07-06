# coding: utf-8
class GundamPhotosController < ApplicationController
  # GET /gundam_photos
  # GET /gundam_photos.json
  def index
    @gundam_photos = GundamPhotoMongo.verified.includes(:gundam).desc(:id).paginate(:page => params[:page] || 1, :limit => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /gundam_photos/1
  # GET /gundam_photos/1.json
  def show
    @gundam_photo = GundamPhoto.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gundam_photo }
    end
  end

  # GET /gundam_photos/new
  # GET /gundam_photos/new.json
  def new
    @gundam = Gundam.find(params[:gundam_id])
    @gundam_photo = @gundam.gundam_photos.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gundam_photo }
    end
  end

  # POST /gundam_photos
  # POST /gundam_photos.json
  def create
    @gundam = Gundam.find(params[:gundam_id])
    @gundam_photo = @gundam.gundam_photos.build(params[:gundam_photo])
    respond_to do |format|
      if @gundam_photo.save
        format.html { redirect_to [@gundam, @gundam_photo], notice: 'Gundam photo was successfully created.' }
        format.json { render json: @gundam_photo, status: :created, location: @gundam_photo }
      else
        format.html { render action: "new" }
        format.json { render json: @gundam_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def avatar
    @gundam_photo = GundamPhoto.find(params[:id])
  end

  # POST /gundam_photos/1/crop
  def crop
    @gundam_photo = GundamPhoto.find(params[:id])
    @gundam_photo.gundam.update_attributes(params.slice(:crop_x, :crop_y, :crop_w, :crop_h).merge({remote_avatar_url: "http://#{request.host_with_port}#{@gundam_photo.image}"}))
    redirect_to @gundam_photo.gundam
  end

end
