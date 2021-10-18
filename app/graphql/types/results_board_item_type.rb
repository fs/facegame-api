module Types
  class ResultsBoardItemType < Types::BaseObject
    field :full_name, String, null: false
    field :avatar_url, String, null: true
    field :score, Integer, null: false
    field :rate, Integer, null: false
  end
end
