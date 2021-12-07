module Types
  class PopularityRatingType < Types::BaseObject
    field :statistic, String, null: false
    field :avatar_url, String, null: true
  end
end
