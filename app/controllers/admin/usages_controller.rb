class Admin::UsagesController < Admin::ApplicationController
  # GET /types/new
  def new
  end

  # POST /types
  def create
    new = {:name=>params[:name]}
    @usage = Usage.new(new)
    if @usage.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@usage.errors.full_messages}
    end
  end

  # DELETE /types/1
  def destroy
    @user = Usage.find(params[:id])
    @user.destroy
    render :json=>{:success=>true}
  end

  # GET /types/1/edit
  def edit
  end

  def edit_data
    render :json=>Usage.find(params[:id]), :layout=>false
  end

  # PUT /types/1
  def update
    @usage = Usage.find(params[:id])
    new = {:name=>params[:name]}
    if @usage.update_attributes(new)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@usage.errors.full_messages}
    end
  end

  # GET /types
  def index
  end

  def index_data
    types = Usage.limit(params[:limit]).offset(params[:start])
    render :text=>"{'totalProperty':#{Usage.count},'root':#{types.to_json()}}", :layout=>false
  end

  def all_data
    render :text=>"{'totalProperty':#{Usage.count},'root':#{Usage.select("id,name").to_json()}}", :layout=>false
  end
end
