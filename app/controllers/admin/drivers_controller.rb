class Admin::DriversController < Admin::ApplicationController
  # GET /drivers/new
  def new
    driver = Driver.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: driver }
    end
  end

  # POST /drivers
  def create
    params_hash = {:name=>params[:name]}
    driver = Driver.new(params_hash)
    if driver.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>driver.errors.full_messages}
    end
  end

  # DELETE /drivers/1
  def destroy
    driver = Driver.find(params[:id])
    driver.destroy
    render :json=>{:success=>true}
  end

  # GET /drivers/1/edit
  def edit
  end

  def edit_data
    render :json=>Driver.find(params[:id]), :layout=>false
  end

  # PUT /drivers/1
  def update
    driver = Driver.find(params[:id])
    params_hash = {:name=>params[:name]}
    if driver.update_attributes(params_hash)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>driver.errors.full_messages}
    end
  end

  # GET /drivers
  def index
  end

  def index_data
    drivers = Driver.limit(params[:limit]).offset(params[:start])
    render :text=>"{'totalProperty':#{Driver.count},'root':#{drivers.to_json()}}", :layout=>false
  end
end
