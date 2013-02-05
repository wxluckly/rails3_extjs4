class Search

  attr_reader :period_id, :dimension_id

  def initialize(params)
    @dimension_id = params["dimension_id"]
    @period_id = params["period_id"]
  end

end