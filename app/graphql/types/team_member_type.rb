module Types
  class TeamMemberType < Types::BaseObject
    field :avatar_url, String, null: true
    field :answer_options, resolver: Resolvers::AnswerOptions

    def avatar_url
      object.avatar(:normal)&.url
    end
  end
end
