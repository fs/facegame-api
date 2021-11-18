class FilteredQuestionsQuery < BaseFilteredQuery
  ALLOWED_PARAMS = %i[excluded_email exluded_question_ids gender excluded_full_name limit].freeze

  def by_excluded_email(relation, email)
    relation.where.not("email LIKE ?", prepared_email_query(email))
  end

  def by_excluded_full_name(relation, full_name)
    relation.where.not(full_name: full_name)
  end

  def by_exluded_question_ids(relation, ids)
    relation.where.not(id: ids)
  end

  def by_gender(relation, gender)
    relation.where(gender: gender)
  end

  def by_limit(relation, value)
    relation.limit(value)
  end

  private

  def prepared_email_query(email)
    "#{email.split('@')[0]}%"
  end
end
