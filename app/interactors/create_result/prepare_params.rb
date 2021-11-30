class CreateResult
  class PrepareParams
    include Interactor

    delegate :params, :current_user, to: :context

    def call
      context.prepared_answers_params = prepared_answers_params
      context.prepared_result_params = prepared_result_params
    end

    private

    def prepared_answers_params
      @prepared_answers_params ||= params[:answers].map do |answer|
        {
          question_id: answer[:question_id],
          value: answer[:value],
          correct: question_correct?(answer)
        }
      end
    end

    def prepared_result_params
      {
        user: current_user,
        score: calculate_score,
        finish_at: Time.current
      }
    end

    def calculate_score
      return 0 if prepared_answers_params.count.zero?

      (correct_answers_count.to_f * correct_answers_count / prepared_answers_params.count * 100).round
    end

    def correct_answers_count
      @correct_answers_count ||= prepared_answers_params.filter { |answer| answer[:correct] }.count
    end

    def answers_count
    end

    def question_correct?(answer)
      question = Question.find_by(id: answer[:question_id])
      context.fail!(error_data: error_data) if question.blank?
      question.full_name == answer[:value]
    end

    def error_data
      { message: "One of the questions not found", code: :not_found, status: 404 }
    end
  end
end
