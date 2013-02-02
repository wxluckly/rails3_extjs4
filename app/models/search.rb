class Search

  attr_reader :period_id, :dimension_id

  def initialize(params)
    @dimension_id = params.slice("dimension_id")
    @period_id = params.slice("period_id")
  end

end