class SendAnswerAndGetNextQuestion
  class PrepareQuestionParams
    include Interactor

    delegate :current_user, :result, to: :context

    def call
      context.filter_options = filter_options
    end

    private

    def filter_options
      {
        excluded_email: current_user.email,
        excluded_question_ids: excluded_question_ids
      }
    end

    def excluded_question_ids
      @excluded_question_ids ||= result.answers.pluck(:question_id)
    end
  end
end
