class SendAnswerAndGetNextQuestion
  class UpdateResultScore
    include Interactor

    delegate :result, to: :context
    delegate :question, to: :answer

    def call
      result.update(result_params)
    end

    private

    def result_params
      {
        score: score
      }
    end

    def score
      return if answers_count.zero?

      (correct_answers_count.to_f * correct_answers_count / answers_count * 100).round
    end

    def correct_answers_count
      @correct_answers_count ||= result.answers.correct.count
    end

    def answers_count
      @answers_count ||= result.answers.answered.count
    end
  end
end
