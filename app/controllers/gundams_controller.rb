# coding: utf-8
class GundamsController < ApplicationController

  # GET /gundams
  def index
    ## use mysql
    # @gundams = Gundam.from_dimension(params[:period_id], params[:dimension_id]).from_period(params[:period_id]).includes(:period).order("periods.year").paginate(:page=>params[:page] || 1, :per_page => 20)

    ## use mongo
    periods_array = PeriodMongo.asc(:year).map(&:id)
    if params[:period_id].present? or params[:dimension_id].present?
      @gundams = Kaminari.paginate_array(GundamMongo.from_dimension(params[:period_id], params[:dimension_id]).from_period(params[:period_id]).includes(:period).sort_by{|o| periods_array.index(o.period_id)}).page(params[:page]).per(20)
    else
      @gundams = Kaminari.paginate_array(GundamMongo.where(:period_id.in => periods_array).includes(:period).sort_by{|o| periods_array.index(o.period_id)}).page(params[:page]).per(20)
    end
    @search = Search.new(params)
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
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
    @gundam_photos = GundamPhotoMongo.verified.where(gundam_id: params[:id]).desc("id")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gundam }
    end
  end

end
