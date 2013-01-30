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

  # GET /gundams/1/edit
  def edit
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

  # GET /gundams
  def index
  end

  # GET /index_data
  def index_data
    gundams = GundamPhoto.limit(params[:limit]).offset(params[:start])  
    render :text=>"{'totalProperty':#{GundamPhoto.count},'root':#{gundams.to_json()}}", :layout=>false
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
