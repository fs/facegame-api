module Types
  class AnswerType < Types::BaseObject
    field :id, ID, null: false
    field :question, QuestionType, null: false
    field :value, String, null: false
    field :correct, Boolean, null: false
  end
end
