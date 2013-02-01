class VersionsController < ApplicationController
  def index
  end

  def show
    if request.xhr?
      @version = GundamVersion.find(params[:id])
    else
      @gundam = Gundam.find(params[:id])
      @version = @gundam.unmerge_versions.first
    end
  end

  def new

  end

  def create

  end

  def merge
    @version = GundamVersion.find(params[:id])
    @version.merge
    redirect_to version_path(id: @version.gundam_id)
  end
end
