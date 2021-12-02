class SendAnswerAndGetNextQuestion
  class FindRandomQuestion
    include Interactor

    delegate :question, :filter_options, to: :context

    def call
      context.fail!(error_data: error_data) if pending_question.nil?
      context.pending_question = pending_question
    end

    private

    def pending_question
      @pending_question ||= filtered_questions.where.not(id: question.id).sample
    end

    def filtered_questions
      @filtered_questions ||= FilteredQuestionsQuery.new(raw_relation, filter_options).all
    end

    def raw_relation
      Question.kept
    end

    def error_data
      { message: "No questions available", code: :not_found, status: 404 }
    end
  end
end
