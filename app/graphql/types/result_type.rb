module Types
  class ResultType < Types::BaseObject
    field :id, ID, null: false
    field :score, Integer, null: false
  end
end
