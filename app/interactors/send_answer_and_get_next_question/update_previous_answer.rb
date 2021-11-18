class SendAnswerAndGetNextQuestion
  class UpdatePreviousAnswer
    include Interactor

    delegate :answer_value, :answer, :correct_answer_value, to: :context
    delegate :question, to: :answer

    def call
      answer.update(answer_params)
    end

    private

    def answer_params
      {
        value: answer_value,
        correct: answer_value_correct?
      }
    end

    def answer_value_correct?
      answer_value == correct_answer_value
    end
  end
end
