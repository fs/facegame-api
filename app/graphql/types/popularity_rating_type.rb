module Types
  class PopularityRatingType < Types::BaseObject
    field :answers_count, Integer, null: false,
                                   deprecation_reason: "Now using statistic string"
    field :correct_answers_count, Integer, null: false,
                                           deprecation_reason: "Now using statistic "
    field :statistic, String, null: false
    field :avatar_url, String, null: true
  end
end
