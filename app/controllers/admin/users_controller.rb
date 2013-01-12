class Admin::UsersController < Admin::ApplicationController

  # GET /users/new
  def new
  end

  # POST /users
  def create
    new_user = {:name=>params[:name],:passwd=>params[:passwd]}
    @user = User.new(new_user)
    if @user.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@user.errors.full_messages}
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render :json=>{:success=>true}
  end

  # GET /users/1/edit
  def edit
  end

  def edit_data
    render :json=>User.find(params[:id]), :layout=>false
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    new_user = {:name=>params[:name],:passwd=>params[:passwd]}
    if @user.update_attributes(new_user)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>@user.errors.full_messages}
    end
  end

  # GET /users
  def index
  end

  def index_data
    render :json=>{:totalProperty=>User.count,:root=>User.limit(params[:limit]).offset(params[:start])}, :layout=>false
  end

  # GET /users/1
  # 展示一条，但基本上不用，而是用edit
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
