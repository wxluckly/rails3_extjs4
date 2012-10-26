class DimensionsController < ApplicationController
  # GET /dimensions/new
  def new
  end

  # POST /dimensions
  def create
    new = {:name=>params[:name]}
    @obj = Dimension.new(new)
    if @obj.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@type.errors.full_messages}
    end
  end

  # DELETE /dimensions/1
  def destroy
    @obj = Dimension.find(params[:id])
    @obj.destroy
    render :json=>{:success=>true}
  end

  # GET /dimensions/1/edit
  def edit
  end

  def edit_data
    render :json=>Dimension.find(params[:id]), :layout=>false
  end

  # PUT /dimensions/1
  def update
    @obj = Dimension.find(params[:id])
    new = {:name=>params[:name]}
    if @obj.update_attributes(new)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@type.errors.full_messages}
    end
  end

  # GET /dimensions
  def index
  end

  def index_data
    dimensions = Dimension.limit(params[:limit]).offset(params[:start])
    render :text=>"{'totalProperty':#{Dimension.count},'root':#{dimensions.to_json()}}", :layout=>false
  end

  def all_data
    render :text=>"{'totalProperty':#{Dimension.count},'root':#{Dimension.select("id,name").to_json()}}", :layout=>false
  end
end
