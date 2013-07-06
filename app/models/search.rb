# coding: utf-8
class Search

  attr_reader :period_id, :dimension_id, :query

  def initialize(params)
    @dimension_id = params["dimension_id"]
    @period_id = params["period_id"]
    @query = params["query"]
  end

end