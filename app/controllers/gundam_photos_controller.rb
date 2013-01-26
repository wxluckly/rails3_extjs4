class GundamPhotosController < ApplicationController
  # GET /gundam_photos
  # GET /gundam_photos.json
  def index
    @gundam_photos = GundamPhoto.order("id desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gundam_photos }
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
    @gundam_photo = GundamPhoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gundam_photo }
    end
  end

  # GET /gundam_photos/1/edit
  def edit
    @gundam_photo = GundamPhoto.find(params[:id])
  end

  # POST /gundam_photos
  # POST /gundam_photos.json
  def create
    @gundam_photo = GundamPhoto.new(params[:gundam_photo])

    respond_to do |format|
      if @gundam_photo.save
        format.html { redirect_to @gundam_photo, notice: 'Gundam photo was successfully created.' }
        format.json { render json: @gundam_photo, status: :created, location: @gundam_photo }
      else
        format.html { render action: "new" }
        format.json { render json: @gundam_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gundam_photos/1
  # PUT /gundam_photos/1.json
  def update
    @gundam_photo = GundamPhoto.find(params[:id])

    respond_to do |format|
      if @gundam_photo.update_attributes(params[:gundam_photo])
        format.html { redirect_to @gundam_photo, notice: 'Gundam photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gundam_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gundam_photos/1
  # DELETE /gundam_photos/1.json
  def destroy
    @gundam_photo = GundamPhoto.find(params[:id])
    @gundam_photo.destroy

    respond_to do |format|
      format.html { redirect_to gundam_photos_url }
      format.json { head :no_content }
    end
  end
end
