# frozen_string_literal: true

module Resolvers
  class ResultsBoard < Resolvers::Base
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder

    argument :limit, Integer, required: true

    type Types::ResultsBoardType, null: false

    private

    def fetch_data
      ::GenerateResultsBoard.call(params: options, current_user: current_user).data
    end
  end
end
