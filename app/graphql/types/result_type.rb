module Types
  class ResultType < Types::BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :answers, [AnswerType], null: false
    field :score, Integer, null: false
  end
end
