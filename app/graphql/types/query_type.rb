module Types
  class QueryType < Types::BaseObject
    field :me, resolver: Resolvers::CurrentUser
    field :questions, resolver: Resolvers::Questions
    field :results_board, resolver: Resolvers::ResultsBoard
    field :popularity_rating, resolver: Resolvers::PopularityRating
    field :images, resolver: Resolvers::Images
  end
end
