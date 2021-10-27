# frozen_string_literal: true

module Resolvers
  class PopularityRating < Resolvers::Base
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder

    type Types::ResultsBoardType, null: false

    private

    def fetch_data
      ::GeneratePopularityRating.call(params: options, current_user: current_user).data
    end
  end
end
