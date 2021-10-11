module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :full_name, String, null: false
    field :department, String, null: false
    field :avatar_url, String, null: true
    field :wrong_answers, resolver: Resolvers::WrongAnswers

    field :activities, resolver: Resolvers::Activities, connection: true

    delegate :avatar, to: :object
    delegate :url, to: :avatar, prefix: true, allow_nil: true
  end
end
