module Types
  class CurrentUserResultType < Types::BaseObject
    field :full_name, String, null: false
    field :score, Integer, null: false
    field :rate, Integer, null: false
    field :questions_count, Integer, null: false
    field :correct_answers_count, Integer, null: false
  end
end
