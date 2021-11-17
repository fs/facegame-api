module Types
  class StartGameType < Types::BaseObject
    field :game_id, ID, null: false
    field :question, Types::TeamMember, null: false
  end

  def game_id
    object.id
  end
end
