module Types
  class AnswerType < Types::BaseObject
    field :id, ID, null: false
    field :question, QuestionType, null: false
    field :value, String, null: true
    field :status, String, null: false
  end
end
