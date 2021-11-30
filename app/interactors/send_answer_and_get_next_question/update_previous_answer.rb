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
        status: status
      }
    end

    def status
      answer_value_correct? ? "correct" : "incorrect"
    end

    def answer_value_correct?
      answer_value == correct_answer_value
    end
  end
end
