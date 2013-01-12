class Admin::TypesController < Admin::ApplicationController
  # GET /types/new
  def new
  end

  # POST /types
  def create
    new = {:name=>params[:name]}
    @type = Type.new(new)
    if @type.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@type.errors.full_messages}
    end
  end

  # DELETE /types/1
  def destroy
    @user = Type.find(params[:id])
    @user.destroy
    render :json=>{:success=>true}
  end

  # GET /types/1/edit
  def edit
  end

  def edit_data
    render :json=>Type.find(params[:id]), :layout=>false
  end

  # PUT /types/1
  def update
    @type = Type.find(params[:id])
    new = {:name=>params[:name]}
    if @type.update_attributes(new)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@type.errors.full_messages}
    end
  end

  # GET /types
  def index
  end

  def index_data
    types = Type.limit(params[:limit]).offset(params[:start])
    render :text=>"{'totalProperty':#{Type.count},'root':#{types.to_json()}}", :layout=>false
  end

  def all_data
    render :text=>"{'totalProperty':#{Type.count},'root':#{Type.select("id,name").to_json()}}", :layout=>false
  end
end
