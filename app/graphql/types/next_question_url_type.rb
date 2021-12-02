module Types
  class NextQuestionUrlType < Types::BaseObject
    field :avatar_url, String, null: true

    def avatar_url
      object.avatar(:normal)&.url
    end
  end
end
