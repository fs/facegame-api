module Mutations
  class EndGame < BaseMutation
    include AuthenticableGraphqlUser

    argument :input, Types::EndGameInput, required: true

    type Types::ResultType

    def resolve(input:)
      end_game_result = ::EndGame.call(
        current_user: context[:current_user],
        game_id: input[:game_id]
      )

      if end_game_result.success?
        end_game_result.result
      else
        execution_error(error_data: result.error_data)
      end
    end
  end
end
