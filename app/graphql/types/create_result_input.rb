module Types
  class CreateResultInput < Types::BaseInputObject
    argument :answers, [AnswerInput], required: true
  end
end
