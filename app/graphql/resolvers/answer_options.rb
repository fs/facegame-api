# frozen_string_literal: true

module Resolvers
  class AnswerOptions < Resolvers::Base
    argument :limit, Integer, required: false, default: 4
    argument :sort_by, String, required: false

    type [String], null: false

    private

    def fetch_data
      sorted_relation.pluck(:full_name).append(correct_answer).shuffle
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
      {
        excluded_email: current_user.email,
        excluded_full_name: correct_answer,
        gender: object.gender,
        limit: options[limit] - 1
      }
    end
  end
end
