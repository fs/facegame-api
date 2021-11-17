module Types
  class MutationType < Types::BaseObject
    field :signin, mutation: Mutations::SignIn
    field :update_token, mutation: Mutations::UpdateToken
    field :signout, mutation: Mutations::SignOut
    field :create_result, mutation: Mutations::CreateResult
    field :start_game, mutation: Mutations::StartGame
  end
end
