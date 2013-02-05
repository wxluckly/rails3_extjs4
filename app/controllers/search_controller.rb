class SearchController < ApplicationController

  def index
    params[:page] ||= 0
    params[:per_page] ||= 20
    params[:query] ||= "gundam"
    @gundams = Gundam.search_by_keywords(params)
  end

end
