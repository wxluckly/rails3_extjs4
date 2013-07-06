# coding: utf-8
class Admin::PeriodsController < Admin::ApplicationController

  # POST /periods
  def create
    params_hash = {:name=>params[:name],:year=>params[:year],:dimension_id=>params[:dimension]}
    period = Period.new(params_hash)
    if period.save
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>period.errors.full_messages}
    end
  end

  # DELETE /periods/1
  def destroy
    @user = Period.find(params[:id])
    @user.destroy
    render :json=>{:success=>true}
  end

  def edit_data
    render :json=>Period.find(params[:id]), :layout=>false
  end

  # PUT /periods/1
  def update
    user = Period.find(params[:id])
    params_hash = {:name=>params[:name],:year=>params[:year],:dimension_id=>params[:dimension]}
    if user.update_attributes(params_hash)
      render :json=>{:success=>true}
    else
      render :json=>{:success=>false,:info=>user.errors.full_messages}
    end
  end

  def index_data
    periods = Period.limit(params[:limit]).offset(params[:start]).order("dimension_id").order(:year)
    render :text=>"{'totalProperty':#{Period.count},'root':#{periods.to_json(:include=>[:dimension])}}", :layout=>false
  end

  def all_data
    render :text=>"{'totalProperty':#{Period.count},'root':#{Period.joins(:dimension).order("dimension_id").order("year").select("periods.id,year,dimensions.name").to_json()}}", :layout=>false
  end
end
