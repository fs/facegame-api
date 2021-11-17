module Types
  class TeamMemberType < Types::BaseObject
    field :id, ID, null: false
    field :avatar_url, String, null: true
    field :answers, resolver: Resolvers::Answers

    def avatar_url
      object.avatar(:normal)&.url
    end
  end
end
