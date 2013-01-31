class VersionsController < ApplicationController
  def index
  end

  def show
    @gundam = Gundam.find(params[:id])
  end

  def new

  end

  def create

  end

  def merge
    
  end
end
