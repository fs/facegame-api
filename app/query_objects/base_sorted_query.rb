class BaseSortedQuery
  attr_reader :relation, :sort_by
  ALLOWED_SORT_TYPES = [].freeze

  def initialize(relation, sort_by)
    @relation = relation
    @sort_by = sort_by
  end

  def all
    return relation unless self.class::ALLOWED_SORT_TYPES.include?(sort_by)

    public_send("by_#{sort_by}", relation)
  end
end
