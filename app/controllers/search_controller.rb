# coding: utf-8
class SearchController < ApplicationController

  def index
    @search = Search.new(params)
    @gundams = Gundam.search_by_keywords(params)
  end

end
