module Types
  class AnswerInput < Types::BaseInputObject
    argument :question_id, ID, required: true
    argument :value, String, required: true
  end
end
