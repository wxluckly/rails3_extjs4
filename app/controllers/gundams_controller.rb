class GundamsController < ApplicationController

  # GET /gundams
  def index
    @gundams = Gundam.all
    @gundams = Gundam.includes(:period).paginate(:page=>params[:page]||1, :per_page=>params[:per_page]||20)
  end

  # GET /gundams/1
  # GET /gundams/1.json
  def show
    @gundam = Gundam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gundam }
    end
  end

  # GET /gundams/1/edit
  def edit
    @gundam = Gundam.find(params[:id])
  end

  # PUT /gundams/1
  # PUT /gundams/1.json
  def update
    @gundam = Gundam.find(params[:id])

    respond_to do |format|
      if @gundam.update_attributes(params[:gundam])
        format.html { redirect_to @gundam, notice: 'Gundam photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gundam.errors, status: :unprocessable_entity }
      end
    end
  end

end
