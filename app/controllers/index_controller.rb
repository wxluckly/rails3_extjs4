class IndexController < ApplicationController

  def index
    params[:page] ||= 0
    params[:per_page] ||= 20
    params[:query] ||= "gundam"
    @result = Gundam.search_by_keywords params rescue nil
  end

end
