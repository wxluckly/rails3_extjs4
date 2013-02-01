class VersionsController < ApplicationController
  def index
  end

  def show
    if request.xhr?
      @version = GundamVersion.find(params[:id])
    else
      @gundam = Gundam.find(params[:id])
      @version = @gundam.versions.first
    end
  end

  def new

  end

  def create

  end

  def merge
    
  end
end
