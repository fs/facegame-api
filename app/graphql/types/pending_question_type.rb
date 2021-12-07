module Types
  class PendingQuestionType < Types::BaseObject
    field :avatar_url, String, null: true

    def avatar_url
      object.avatar(:normal)&.url
    end
  end
end
