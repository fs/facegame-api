module Types
  class StartGameType < Types::BaseObject
    field :game_id, ID, null: false
    field :question, Types::TeamMemberType, null: false
    field :next_question_url, Types::NextQuestionUrlType, null: false

    def game_id
      object.result.id
    end
  end
end
