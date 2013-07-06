# coding: utf-8
class Admin::GundamsController < Admin::ApplicationController

  # POST /gundams
  def create
    params_hash = {:name=>params[:name],:model=>params[:model],:name_chs=>params[:name_chs],
      :period_id=>params[:period],:usage_id=>params[:usage]}
    @obj = Gundam.new(params_hash)
    if @obj.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@obj.errors.full_messages}
    end
  end

  # DELETE /gundams/1
  def destroy
    @obj = Gundam.find(params[:id])
    @obj.destroy
    render :json=>{:success=>true}
  end

  def edit_data
    render :json=>Gundam.find(params[:id]), :layout=>false
  end

  # PUT /gundams/1
  def update
    gundam = Gundam.find(params[:id])
    if gundam.update_attributes(params.except(:id, :controller, :action))
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@obj.errors.full_messages}
    end
  end

  # GET /index_data
  def index_data
    gundams = Gundam.includes(:usage, :raw_gundams, [:period=>:dimension]).limit(params[:limit]).offset(params[:start])  
    render :text=>"{'totalProperty':#{Gundam.count},'root':#{gundams.to_json(:include=>[:usage, :raw_gundams, :period => {:include=>:dimension}])}}", :layout=>false
  end

  # GET /send_info
  def send_info
    emails = emails || ["wxl_test@126.com"]
    emails.each do |email|
      Resque.enqueue(InfoMailer, email, params[:gundam_id])
    end
    render :json=>{:success=>true}
  end

end
