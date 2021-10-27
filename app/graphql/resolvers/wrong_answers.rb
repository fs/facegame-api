# frozen_string_literal: true

module Resolvers
  class WrongAnswers < Resolvers::Base
    argument :limit, Integer, required: false
    argument :sort_by, String, required: false

    type [String], null: false

    private

    def fetch_data
      sorted_relation.pluck(:full_name)
    end

    def sorted_relation
      SortedQuestionsQuery.new(filtered_relation, options[:sort_by]).all
    end

    def filtered_relation
      FilteredQuestionsQuery.new(raw_relation, filter_options).all
    end

    def raw_relation
      Question.kept
    end

    def correct_answer
      @correct_answer ||= object.full_name
    end

    def filter_options
      options.merge(excluded_email: current_user.email, excluded_full_name: correct_answer, gender: object.gender)
    end
  end
end
