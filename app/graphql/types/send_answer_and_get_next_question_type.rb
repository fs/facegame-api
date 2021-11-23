module Types
  class SendAnswerAndGetNextQuestionType < Types::BaseObject
    field :correct_answers_count, Integer, null: false
    field :correct_answer_value, String, null: false
    field :question, Types::TeamMemberType, null: false
  end
end
