class StartGame
  class CreateResultAnswers
    include Interactor

    delegate :question, :pending_question, :result, to: :context

    def call
      context.fail!(error_data: error_data) unless current_answer.save || pending_answer.save
    end

    private

    def current_answer
      @current_answer ||= Answer.new(current_answer_params)
    end

    def pending_answer
      @pending_answer ||= Answer.new(pending_answer_params)
    end

    def current_answer_params
      {
        status: "current",
        question: question,
        result: result
      }
    end

    def pending_answer_params
      {
        status: "pending",
        question: pending_question,
        result: result
      }
    end

    def error_data
      { message: "Record Invalid", detail: context.result.errors.to_a }
    end
  end
end
