class SendAnswerAndGetNextQuestion
  class PrepareParams
    include Interactor

    delegate :params, :current_user, to: :context
    delegate :question, to: :answer

    def call
      context.fail!(error_data: error_data) if result.blank?

      context.result = result
      context.answer = answer
      context.correct_answer_value = question.full_name
    end

    private

    def result
      @result ||= Result.active.find_by(user: current_user, id: params[:game_id])
    end

    def answer
      result.answers.current.last
    end

    def error_data
      { message: "Result not found", code: :not_found, status: 404 }
    end
  end
end
