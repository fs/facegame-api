class SortedQuestionsQuery < BaseSortedQuery
  ALLOWED_SORT_TYPES = %w[random id].freeze

  def by_random(relation)
    relation.order("RANDOM()")
  end

  def by_id(relation)
    relation.order(:id)
  end
end
