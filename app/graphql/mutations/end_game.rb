module Mutations
  class EndGame < BaseMutation
    include AuthenticableGraphqlUser

    argument :input, Types::EndGameInput, required: true

    type Types::ResultType

    def resolve(input:)
      result = ::EndGame.call(
        current_user: context[:current_user],
        game_id: input
      )

      if result.success?
        result
      else
        execution_error(error_data: result.error_data)
      end
  end
end
