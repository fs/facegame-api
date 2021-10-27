module Types
  class PopularityRatingType < Types::BaseObject
    field :answers_count, Integer, null: false
    field :correct_answers_count, Integer, null: false
  end
end
