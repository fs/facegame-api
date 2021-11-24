module Types
  class EndGameInput < Types::BaseInputObject
    argument :game_id, ID, required: true
  end
end
