class IndexController < ApplicationController

  def index
    params[:page] ||= 0
    params[:per_page] ||= 20
    params[:query] ||= "gundam"
    @gundams = GundamMongo.includes(:period).find(Gundam.search_by_keywords(params).collect(&:id))
  end

end
