# frozen_string_literal: true

module Resolvers
  class Questions < Resolvers::Base
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder

    argument :limit, Integer, required: false
    argument :sort_by, String, required: false

    type [Types::QuestionType], null: false

    private

    def fetch_data
      sorted_relation
    end

    def sorted_relation
      SortedQuestionsQuery.new(filtered_relation, options[:sort_by]).all
    end

    def filtered_relation
      FilteredQuestionsQuery.new(raw_relation, options).all
    end

    def raw_relation
      Question.kept.where.not(email: current_user.email)
    end
  end
end
