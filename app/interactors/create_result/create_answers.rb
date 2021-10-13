class CreateResult
  class CreateAnswers
    include Interactor

    delegate :prepared_answers_params, :result, to: :context

    def call
      result.answers.import(new_answers)
    end

    private

    def new_answers
      prepared_answers_params.map { |answer_data| Answer.new(answer_data) }
    end
  end
end
