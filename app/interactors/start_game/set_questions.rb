class StartGame
  class SetQuestions
    include Interactor

    delegate :filter_options, to: :context

    def call
      context.fail!(error_data: error_data) if question.nil?
      context.current_question = current_question
      context.next_question_url = next_question_url
    end

    private

    def current_question
      @current_question ||= filtered_questions.sample 
    end

    def next_question_url
      @next_question ||= (filtered_questions.delete(current_question)).sample
    end

    def filtered_questions
      FilteredQuestionsQuery.new(raw_relation, filter_options).all
    end
    
    def raw_relation
      Question.kept
    end

    def error_data
      { message: "No questions available", code: :not_found, status: 404 }
    end
  end
end
