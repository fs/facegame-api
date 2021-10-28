module Types
  class PopularityRatingType < Types::BaseObject
    field :answers_count, Integer, null: false
    field :correct_answers_count, Integer, null: false
    field :avatar_url, String, null: true
  end
end
