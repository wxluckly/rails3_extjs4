class GundamsController < ApplicationController
  # GET /gundams/new
  def new
  end

  # POST /gundams
  def create
    params_hash = {:name=>params[:name],:model=>params[:model],:name_chs=>params[:name_chs],
      :period_id=>params[:period],:type_id=>params[:type]}
    @obj = Gundam.new(params_hash)
    if @obj.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@obj.errors.full_messages}
    end
  end

  # DELETE /gundams/1
  def destroy
    @user = Gundam.find(params[:id])
    @user.destroy
    render :json=>{:success=>true}
  end

  # GET /gundams/1/edit
  def edit
  end

  def edit_data
    render :json=>Gundam.find(params[:id]), :layout=>false
  end

  # PUT /gundams/1
  def update
    @user = Gundam.find(params[:id])
    new_user = {:name=>params[:name],:passwd=>params[:passwd]}
    if @user.update_attributes(new_user)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@user.errors.full_messages}
    end
  end

  # GET /gundams
  def index
  end

  def index_data

    gundams = Gundam.includes(:period,:type).limit(params[:limit]).offset(params[:start])
    
    render :text=>"{'totalProperty':#{Gundam.count},'root':#{gundams.to_json(:include=>[:period,:type])}}", :layout=>false
  end
end
