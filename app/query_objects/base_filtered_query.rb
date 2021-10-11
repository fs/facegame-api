class BaseFilteredQuery
  def initialize(relation, filter_params = {})
    @relation = relation
    @filter_params = sanitized_filter_params(filter_params)
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      public_send("by_#{key}", relation, value)
    end
  end

  private

  def sanitized_filter_params(params)
    params
      .to_h
      .deep_symbolize_keys
      .reject { |k, v| !self.class::ALLOWED_PARAMS.include?(k) || v.to_s.blank? }
  end

  attr_reader :relation, :filter_params
end
