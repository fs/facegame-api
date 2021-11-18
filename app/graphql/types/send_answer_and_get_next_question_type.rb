module Types
  class SendAnswerAndGetNextQuestionType < Types::BaseObject
    field :correct_answer_value, String, null: false
    field :question, Types::TeamMemberType, null: false
  end
end
