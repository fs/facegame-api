module Types
  class SendAnswerAndGetNextQuestionType < Types::BaseObject
    field :correct_answers_count, Integer, null: false
    field :correct_answer_value, String, null: false, description: "Correct answer value for previous answer"
    field :question, Types::TeamMemberType, null: false
    field :pending_question, Types::PendingQuestionType, null: true
  end
end
