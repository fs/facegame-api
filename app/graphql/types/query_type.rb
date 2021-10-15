module Types
  class QueryType < Types::BaseObject
    field :me, resolver: Resolvers::CurrentUser
    field :activities, resolver: Resolvers::Activities, connection: true
    field :questions, resolver: Resolvers::Questions
    field :results_board, resolver: Resolvers::ResultsBoard
  end
end
