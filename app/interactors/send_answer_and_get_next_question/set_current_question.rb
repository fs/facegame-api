class SendAnswerAndGetNextQuestion
  class SetCurrentQuestion
    include Interactor

    delegate :result, to: :context

    def call
      context.fail!(error_data: error_data) if pending_answer.nil?
      context.question = question
    end

    private

    def pending_answer
      @pending_answer ||= result.answers.pending.last
    end

    def updated_pending_answer
      pending_answer.update(status: "current")
      pending_answer
    end

    def question
      updated_pending_answer.question
    end

    def error_data
      byebug
      { message: "No questions available", code: :not_found, status: 404 }
    end
  end
end
