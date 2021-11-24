module Types
  class AnswerAndNewQuestionInput < Types::BaseInputObject
    argument :game_id, ID, required: true
    argument :value, String, required: true
  end
end
