class GundamsController < ApplicationController

  # GET /gundams
  def index
    @gundams = Gundam.includes(:period).paginate(:page=>params[:page]||1, :per_page=>params[:per_page]||20)
  end

end
