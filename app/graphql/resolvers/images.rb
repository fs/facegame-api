# frozen_string_literal: true

module Resolvers
  class Images < Resolvers::Base
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder

    type [String], null: false

    private

    def fetch_data
      Question.all.map { |question| question.avatar_url(:normal) }
    end
  end
end
