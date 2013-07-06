# coding: utf-8
class Admin::GundamPhotosController < Admin::ApplicationController
  # GET /gundams/new
  def new
  end

  # POST /gundams
  def create
    params_hash = {:name=>params[:name],:model=>params[:model],:name_chs=>params[:name_chs],
      :period_id=>params[:period],:usage_id=>params[:usage]}
    @obj = GundamPhoto.new(params_hash)
    if @obj.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@obj.errors.full_messages}
    end
  end

  # DELETE /gundams/1
  def destroy
    @obj = GundamPhoto.find(params[:id])
    @obj.destroy
    render :json=>{:success=>true}
  end

  def edit_data
    render :json=>GundamPhoto.find(params[:id]), :layout=>false
  end

  # PUT /gundams/1
  def update
    gundam = GundamPhoto.find(params[:id])
    if gundam.update_attributes(params.except(:id, :controller, :action))
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@obj.errors.full_messages}
    end
  end

  # GET /index_data
  def index_data
    gundams = GundamPhoto.unverified.includes(:gundam).limit(params[:limit]).offset(params[:start])  
    render :text=>"{'totalProperty':#{GundamPhoto.count},'root':#{gundams.to_json(:include=>:gundam)}}", :layout=>false
  end

  # GET /send_info
  def set_verified
    @obj = GundamPhoto.find(params[:id])
    @obj.update_attribute("is_verified", true)
    render :json=>{:success=>true}
  end

end
