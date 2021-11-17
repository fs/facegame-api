module Mutations
  class StartGame < BaseMutation
    include AuthenticableGraphqlUser

    type Types::StartGameType

    def resolve
      if start_game.success?
        start_game
      else
        execution_error(error_data: start_game.error_data)
      end
    end

    private

    def start_game
      @start_game ||= ::StartGame.call(current_user: context[:current_user])
    end
  end
end
