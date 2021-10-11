class FilteredQuestionsQuery < BaseFilteredQuery
  ALLOWED_PARAMS = [:limit].freeze

  def by_limit(relation, value)
    relation.limit(value)
  end
end
