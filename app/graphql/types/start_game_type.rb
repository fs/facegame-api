module Types
  class StartGameType < Types::BaseObject
    field :game_id, ID, null: false
    field :question, Types::TeamMemberType, null: false
  end

  def game_id
    object.result.id
  end
end
