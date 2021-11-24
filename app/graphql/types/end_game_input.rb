module Types
  class EndGameInput < Types::BaseInputObject
    argument :game_id, Integer, required: true
  end
end
